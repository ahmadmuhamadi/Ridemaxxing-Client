import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/glass.dart';
import '../widgets/map_background.dart';
import '../widgets/past_trips_view.dart';
import '../widgets/upcoming_trip_card.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({required this.onBookRide, super.key});

  final VoidCallback onBookRide;

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  bool _past = false;
  final Set<String> _cancelled = {};
  final Map<String, int> _ratings = {};
  late Future<List<UpcomingTrip>> _upcoming = _fetchUpcoming();
  late Future<(MonthStats, List<PastTrip>)> _pastTrips = _fetchPast();

  // The backend doesn't exist yet, so these always fail for now.
  Future<List<UpcomingTrip>> _fetchUpcoming() async {
    try {
      throw Exception('Backend not connected');
    } catch (e) {
      debugPrint('[RideMaxxing] Loading upcoming trips failed: $e');
      rethrow;
    }
  }

  Future<(MonthStats, List<PastTrip>)> _fetchPast() async {
    try {
      throw Exception('Backend not connected');
    } catch (e) {
      debugPrint('[RideMaxxing] Loading past trips failed: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: const AppHeader(),
      body: Stack(
        children: [
          const Positioned.fill(child: MapBackground()),
          Column(
            children: [
              Glass(
                radius: 0,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Trips',
                      style: TextStyle(
                        fontSize: 32,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.64,
                        color: c.ink,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _segment(c),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 128),
                  children: _past ? _pastList(c) : _upcomingList(c),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _segment(AppColors c) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: c.line,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final (past, label) in [(false, 'Upcoming'), (true, 'Past')])
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _past = past),
                child: Container(
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: past == _past ? c.surface : null,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: past == _past
                        ? [
                            BoxShadow(
                              color: c.shadow,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: c.ink,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _upcomingList(AppColors c) => [
    FutureBuilder(
      future: _upcoming,
      builder: (context, snap) {
        if (snap.hasError) {
          return _error(c, () => _upcoming = _fetchUpcoming()..ignore());
        }
        if (!snap.hasData) return _loading();
        return Column(
          children: [
            for (final t in snap.data!) ...[
              UpcomingTripCard(
                trip: t,
                cancelled: _cancelled.contains(t.id),
                onCancel: () => setState(() => _cancelled.add(t.id)),
                onUndo: () => setState(() => _cancelled.remove(t.id)),
              ),
              const SizedBox(height: 16),
            ],
          ],
        );
      },
    ),
    GestureDetector(
      onTap: widget.onBookRide,
      child: Glass(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: c.primarySoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.search, size: 22, color: c.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book another ride',
                    style: TextStyle(fontWeight: FontWeight.w600, color: c.ink),
                  ),
                  Text(
                    'Your regular routes are one tap away',
                    style: TextStyle(fontSize: 13, color: c.muted),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: c.muted),
          ],
        ),
      ),
    ),
  ];

  List<Widget> _pastList(AppColors c) => [
    FutureBuilder(
      future: _pastTrips,
      builder: (context, snap) {
        if (snap.hasError) {
          return _error(c, () => _pastTrips = _fetchPast()..ignore());
        }
        if (!snap.hasData) return _loading();
        final (stats, trips) = snap.data!;
        return PastTripsView(
          stats: stats,
          trips: trips,
          ratings: _ratings,
          onRate: (id, v) => setState(() => _ratings[id] = v),
        );
      },
    ),
  ];

  Widget _loading() => const Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
  );

  Widget _error(AppColors c, VoidCallback retry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Glass(
        padding: const EdgeInsets.fromLTRB(16, 6, 6, 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Couldn't load your trips. Check your connection.",
                style: TextStyle(fontSize: 13, color: c.danger),
              ),
            ),
            TextButton(
              onPressed: () => setState(retry),
              child: Text('Try again', style: TextStyle(color: c.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
