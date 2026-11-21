import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_chip.dart';
import '../widgets/app_header.dart';
import '../widgets/glass.dart';
import '../widgets/map_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/route_marker.dart';
import '../utils/location.dart';
import 'results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _from = TextEditingController();
  final _to = TextEditingController();
  TimeOfDay _time = TimeOfDay.now();
  int _seats = 1;
  late Future<List<(String, String)>> _routes = _fetchRoutes();

  static const _routeIcons = {
    'commute': Icons.home_outlined,
    'beach': Icons.beach_access_outlined,
    'park': Icons.park_outlined,
    'airport': Icons.flight_outlined,
  };

  // (label, kind) pairs from the backend, which doesn't exist yet.
  Future<List<(String, String)>> _fetchRoutes() async {
    try {
      throw Exception('Backend not connected');
    } catch (e) {
      debugPrint('[RideMaxxing] Loading regular routes failed: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _locate();
  }

  Future<void> _locate() async {
    final position = await getCurrentLocation();
    if (position != null && mounted && _from.text.isEmpty) {
      _from.text = 'Current location';
    }
  }

  @override
  void dispose() {
    _from.dispose();
    _to.dispose();
    super.dispose();
  }

  void _swap() {
    final from = _from.text;
    _from.text = _to.text;
    _to.text = from;
  }

  void _findRides() {
    final to = _to.text.trim();
    if (to.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick a destination first.')),
      );
      return;
    }
    final from = _from.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsPage(
          from: from.isEmpty ? 'Current location' : from,
          to: to,
          time: _time,
          seats: _seats,
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final small = TextStyle(fontSize: 13, color: c.muted);
    return Scaffold(
      appBar: const AppHeader(avatar: true),
      body: Builder(
        builder: (context) => Stack(
          children: [
            const Positioned.fill(child: MapBackground()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Glass(
                radius: Radii.sheet,
                topOnly: true,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: MediaQuery.paddingOf(context).bottom + 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 38,
                          height: 5,
                          decoration: BoxDecoration(
                            color: c.line,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Where to?',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                                color: c.ink,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _routeFields(c),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(flex: 5, child: _timeField(c, small)),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Seats', style: small),
                                      const SizedBox(height: 4),
                                      _seatPicker(c),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            PrimaryButton('Find rides', onPressed: _findRides),
                            const SizedBox(height: 16),
                            Text(
                              'Your regular routes',
                              style: small.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: _routes,
                        builder: (context, snap) => _regularRoutes(c, snap),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _regularRoutes(
    AppColors c,
    AsyncSnapshot<List<(String, String)>> snap,
  ) {
    if (snap.hasError) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Couldn't load your regular routes.",
                style: TextStyle(fontSize: 13, color: c.danger),
              ),
            ),
            TextButton(
              onPressed: () => setState(() {
                _routes = _fetchRoutes()..ignore();
              }),
              child: Text('Try again', style: TextStyle(color: c.primary)),
            ),
          ],
        ),
      );
    }
    if (!snap.hasData) {
      return const SizedBox(
        height: 36,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final (label, kind) in snap.data!) ...[
            AppChip(
              label,
              icon: _routeIcons[kind] ?? Icons.place_outlined,
              onTap: () {},
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _routeFields(AppColors c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: c.line,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 56),
            child: Column(
              children: [
                _field(c, 'From', _from, const EdgeInsets.only(bottom: 6)),
                Container(height: 1, color: c.line),
                _field(c, 'To', _to, const EdgeInsets.only(top: 6)),
              ],
            ),
          ),
          Positioned(left: 0, top: 24, bottom: 16, child: RouteMarker()),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                onPressed: _swap,
                tooltip: 'Swap origin and destination',
                style: IconButton.styleFrom(
                  backgroundColor: c.surface,
                  fixedSize: const Size(44, 44),
                ),
                icon: Icon(Icons.swap_vert, size: 18, color: c.ink),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    AppColors c,
    String label,
    TextEditingController ctrl,
    EdgeInsets pad,
  ) {
    final style = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: c.ink,
    );
    return Padding(
      padding: pad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: c.muted)),
          const SizedBox(height: 2),
          TextField(
            controller: ctrl,
            autocorrect: false,
            style: style,
            decoration: InputDecoration.collapsed(
              hintText: label == 'To' ? 'Search a place' : null,
              hintStyle: style.copyWith(color: c.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeField(AppColors c, TextStyle small) {
    return GestureDetector(
      onTap: _pickTime,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: c.line,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Leave at', style: small),
            const SizedBox(height: 4),
            Text(_time.format(context), style: numStyle(18, c.ink)),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  Widget _seatPicker(AppColors c) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: c.line,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final n in [1, 2, 3])
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _seats = n),
                child: Container(
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: n == _seats ? c.surface : null,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text('$n', style: numStyle(18, c.ink)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
