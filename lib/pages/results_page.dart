import 'package:flutter/material.dart';

import '../data/rides_api.dart';
import '../models/ride.dart';
import '../theme/app_theme.dart';
import '../widgets/glass.dart';
import '../widgets/map_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/ride_card.dart';
import 'ride_details_page.dart';

enum _Sort { earliest, cheapest }

enum _Filter {
  instantBook('Instant book'),
  petsOk('Pets OK'),
  womenDrivers('Women drivers');

  const _Filter(this.label);
  final String label;

  bool matches(Ride r) => switch (this) {
    instantBook => r.instantBook,
    petsOk => r.petsOk,
    womenDrivers => r.womanDriver,
  };
}

/// Rides for a searched route. Back and edit both return to the search form.
class ResultsPage extends StatefulWidget {
  const ResultsPage({
    required this.from,
    required this.to,
    required this.time,
    required this.seats,
    super.key,
  });

  final String from, to;
  final TimeOfDay time;
  final int seats;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late Future<List<Ride>> _rides = _search();
  _Sort _sort = _Sort.earliest;
  final _filters = <_Filter>{};

  Future<List<Ride>> _search() => searchRides(
    from: widget.from,
    to: widget.to,
    time: widget.time,
    seats: widget.seats,
  );

  List<Ride> _visible(List<Ride> rides) {
    final list = rides.where((r) => _filters.every((f) => f.matches(r)));
    return list.toList()..sort(
      (a, b) => switch (_sort) {
        _Sort.earliest => a.compareByDeparture(b),
        _Sort.cheapest =>
          a.price != b.price ? a.price - b.price : a.compareByDeparture(b),
      },
    );
  }

  void _openRide(Ride ride) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RideDetailsPage(ride: ride)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _header(context),
      body: Stack(
        children: [
          const Positioned.fill(child: MapBackground()),
          FutureBuilder(
            future: _rides,
            builder: (context, snap) => _body(context, snap),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    final c = context.colors;
    final seats = '${widget.seats} seat${widget.seats == 1 ? '' : 's'}';
    final time = MaterialLocalizations.of(context).formatTimeOfDay(widget.time);
    return PreferredSize(
      preferredSize: const Size.fromHeight(124),
      child: Glass(
        radius: 0,
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Back',
                      onPressed: () => Navigator.maybePop(context),
                      icon: Icon(Icons.chevron_left, color: c.ink),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${widget.from} to ${widget.to}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: c.ink,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Today, leaving around $time, $seats',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13, color: c.muted),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Edit search',
                      onPressed: () => Navigator.maybePop(context),
                      icon: Icon(Icons.edit_outlined, size: 20, color: c.ink),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Row(
                  children: [
                    _chip(c, 'Earliest', _sort == _Sort.earliest, () {
                      setState(() => _sort = _Sort.earliest);
                    }),
                    _chip(c, 'Cheapest', _sort == _Sort.cheapest, () {
                      setState(() => _sort = _Sort.cheapest);
                    }),
                    for (final f in _Filter.values)
                      _chip(c, f.label, _filters.contains(f), () {
                        setState(() {
                          if (!_filters.remove(f)) _filters.add(f);
                        });
                      }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(AppColors c, String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Semantics(
        button: true,
        selected: selected,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? c.primary : c.glass,
              borderRadius: BorderRadius.circular(Radii.pill),
              border: Border.all(color: selected ? c.primary : c.line),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected ? c.onPrimary : c.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AsyncSnapshot<List<Ride>> snap) {
    final c = context.colors;
    final pad = MediaQuery.paddingOf(context);
    final top = pad.top + 124 + 12;

    if (snap.hasError) {
      return _message(
        c,
        top,
        icon: Icons.cloud_off_outlined,
        title: "Couldn't load rides",
        body: 'Check your connection and try again.',
        action: 'Try again',
        onAction: () => setState(() => _rides = _search()),
      );
    }
    if (!snap.hasData) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    final rides = _visible(snap.data!);
    if (rides.isEmpty) {
      final filtered = _filters.isNotEmpty;
      return _message(
        c,
        top,
        icon: Icons.search_off,
        title: filtered ? 'No rides match' : 'No rides yet',
        body: filtered
            ? 'Try turning off a filter or two.'
            : 'Nobody is driving this route around then. Try another time.',
        action: filtered ? 'Clear filters' : null,
        onAction: () => setState(_filters.clear),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16, top, 16, pad.bottom + 24),
      itemCount: rides.length + 1,
      separatorBuilder: (_, i) => SizedBox(height: i == 0 ? 10 : 12),
      itemBuilder: (context, i) {
        if (i == 0) {
          final n = rides.length;
          return Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              '$n ride${n == 1 ? '' : 's'} heading your way',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: c.ink,
              ),
            ),
          );
        }
        final ride = rides[i - 1];
        return RideCard(ride, onTap: () => _openRide(ride));
      },
    );
  }

  Widget _message(
    AppColors c,
    double top, {
    required IconData icon,
    required String title,
    required String body,
    String? action,
    VoidCallback? onAction,
  }) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16, top, 16, 24),
      children: [
        Glass(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(icon, size: 36, color: c.muted),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: c.ink,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: c.muted),
              ),
              if (action != null) ...[
                const SizedBox(height: 18),
                PrimaryButton(action, onPressed: onAction),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
