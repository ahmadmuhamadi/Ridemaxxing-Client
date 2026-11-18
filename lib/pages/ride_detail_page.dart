import 'package:flutter/material.dart';

import '../models/ride_detail.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/glass.dart';
import '../widgets/map_background.dart';
import '../widgets/primary_button.dart';
import '../widgets/ride_info.dart';
import '../widgets/route_line.dart';

class RideDetailPage extends StatefulWidget {
  const RideDetailPage({required this.rideId, super.key});

  final String rideId;

  @override
  State<RideDetailPage> createState() => _RideDetailPageState();
}

class _RideDetailPageState extends State<RideDetailPage> {
  late Future<RideDetail> _ride = _fetchRide();

  // The backend doesn't exist yet, so this always fails for now.
  Future<RideDetail> _fetchRide() async {
    try {
      throw Exception('Backend not connected');
    } catch (e) {
      debugPrint('[RideMaxxing] Loading ride ${widget.rideId} failed: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return FutureBuilder(
      future: _ride,
      builder: (context, snap) => Scaffold(
        appBar: const AppHeader(),
        bottomNavigationBar: snap.hasData ? _actionBar(c, snap.data!) : null,
        body: Stack(
          children: [
            const Positioned.fill(child: MapBackground()),
            if (snap.hasData)
              const Positioned(
                top: 30,
                left: 0,
                right: 0,
                height: 220,
                child: RouteLine(),
              ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 260),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height - 260,
                    ),
                    child: Glass(
                      radius: Radii.sheet,
                      topOnly: true,
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
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
                          const SizedBox(height: 20),
                          if (snap.hasError)
                            _error(c)
                          else if (snap.hasData)
                            RideInfo(ride: snap.data!)
                          else
                            const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _roundButton(c, Icons.chevron_left, 'Back', () {
                    Navigator.pop(context);
                  }),
                  _roundButton(c, Icons.ios_share, 'Share this ride', () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBar(AppColors c, RideDetail r) {
    return Glass(
      radius: 0,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(r.price, style: numStyle(30, c.ink)),
              Text('per seat', style: TextStyle(fontSize: 13, color: c.muted)),
            ],
          ),
          const SizedBox(width: 14),
          IconButton(
            onPressed: () {},
            tooltip: 'Message ${r.driver.split(' ').first}',
            style: IconButton.styleFrom(
              backgroundColor: c.primarySoft,
              fixedSize: const Size(44, 44),
            ),
            icon: Icon(Icons.chat_bubble_outline, size: 20, color: c.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: PrimaryButton('Book seat for ${r.price}', onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _roundButton(
    AppColors c,
    IconData icon,
    String tooltip,
    VoidCallback onTap,
  ) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Glass(
          radius: Radii.pill,
          child: SizedBox.square(
            dimension: 44,
            child: Icon(icon, size: 22, color: c.ink),
          ),
        ),
      ),
    );
  }

  Widget _error(AppColors c) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Couldn't load this ride. Check your connection.",
            style: TextStyle(fontSize: 13, color: c.danger),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _ride = _fetchRide()..ignore()),
          child: Text('Try again', style: TextStyle(color: c.primary)),
        ),
      ],
    );
  }
}
