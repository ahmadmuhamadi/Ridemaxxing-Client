import 'package:flutter/material.dart';

import '../data/ride_history_data.dart';
import '../models/ride_history.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/glass.dart';
import '../widgets/ride_history_card.dart';

enum RideHistoryView { trips, drives }

class RideHistoryPage extends StatefulWidget {
  const RideHistoryPage({super.key});

  @override
  State<RideHistoryPage> createState() => _RideHistoryPageState();
}

class _RideHistoryPageState extends State<RideHistoryPage> {
  RideHistoryView _view = RideHistoryView.trips;
  late List<PassengerRide> _trips;
  late List<DriverRide> _drives;

  @override
  void initState() {
    super.initState();
    _loadMockHistory();
  }

  void _loadMockHistory() {
    _trips = [...passengerRideHistory]
      ..sort((a, b) => b.departureAt.compareTo(a.departureAt));
    _drives = [...driverRideHistory]
      ..sort((a, b) => b.departureAt.compareTo(a.departureAt));
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(_loadMockHistory);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final items = _view == RideHistoryView.trips
        ? _trips.cast<RideHistoryItem>()
        : _drives.cast<RideHistoryItem>();
    return Scaffold(
      appBar: const AppHeader(avatar: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ride history',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -.5,
                    color: c.ink,
                  ),
                ),
                const SizedBox(height: 14),
                _HistorySegmentedControl(
                  value: _view,
                  onChanged: (value) => setState(() => _view = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: items.isEmpty
                  ? _EmptyHistory(view: _view, onRefresh: _refresh)
                  : RefreshIndicator(
                      key: ValueKey(_view),
                      color: c.primary,
                      onRefresh: _refresh,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          16,
                          2,
                          16,
                          MediaQuery.paddingOf(context).bottom + 112,
                        ),
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (_, index) => RideHistoryCard(
                          key: ValueKey(items[index].id),
                          ride: items[index],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistorySegmentedControl extends StatelessWidget {
  const _HistorySegmentedControl({
    required this.value,
    required this.onChanged,
  });

  final RideHistoryView value;
  final ValueChanged<RideHistoryView> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Glass(
      radius: 16,
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        height: 44,
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeInOutCubic,
              alignment: value == RideHistoryView.trips
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: .5,
                heightFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: c.primarySoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                _Segment(
                  label: 'My Trips',
                  selected: value == RideHistoryView.trips,
                  onTap: () => onChanged(RideHistoryView.trips),
                ),
                _Segment(
                  label: 'My Drives',
                  selected: value == RideHistoryView.drives,
                  onTap: () => onChanged(RideHistoryView.drives),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: selected ? c.primary : c.muted,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.view, required this.onRefresh});

  final RideHistoryView view;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final trips = view == RideHistoryView.trips;
    return RefreshIndicator(
      key: ValueKey(view),
      color: c.primary,
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 36, 16, 120),
        children: [
          Glass(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Icon(
                  trips ? Icons.luggage_outlined : Icons.route_outlined,
                  size: 40,
                  color: c.muted,
                ),
                const SizedBox(height: 12),
                Text(
                  trips ? 'No trips taken yet' : 'No rides offered yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: c.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  trips
                      ? 'Your passenger trips will appear here.'
                      : 'The rides you host will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: c.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
