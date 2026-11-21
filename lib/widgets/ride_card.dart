import 'package:flutter/material.dart';

import '../models/ride.dart';
import '../theme/app_theme.dart';
import 'glass.dart';

class RideCard extends StatelessWidget {
  const RideCard(this.ride, {this.onTap, super.key});

  final Ride ride;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final seats =
        '${ride.seatsLeft} seat${ride.seatsLeft == 1 ? '' : 's'} left';
    return Semantics(
      button: true,
      label:
          '${clock(ride.departure)} to ${clock(ride.arrival)}, '
          '${ride.pickup} to ${ride.dropoff}, ${ride.driverName}, '
          '\$${ride.price}${ride.instantBook ? ', instant book' : ''}',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Glass(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _timeline(c),
              const SizedBox(height: 10),
              Text(
                '${ride.pickup} to ${ride.dropoff}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, color: c.muted),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Container(height: 1, color: c.line),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: c.primarySoft,
                    child: Text(
                      ride.initials,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: ride.driverName,
                                style: TextStyle(color: c.ink),
                              ),
                              TextSpan(
                                text: '  ★ ${ride.rating.toStringAsFixed(1)}',
                                style: TextStyle(color: c.gold),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${ride.car}, $seats',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: c.muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${ride.price}', style: numStyle(30, c.ink)),
                      if (ride.instantBook) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Instant book',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: c.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeline(AppColors c) {
    return Row(
      children: [
        Text(clock(ride.departure), style: numStyle(32, c.ink)),
        const SizedBox(width: 10),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: c.primary, width: 2.5),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _dash(c)),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '${ride.durationMinutes} min',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 13, color: c.muted),
                  ),
                ),
              ),
              Expanded(child: _dash(c)),
            ],
          ),
        ),
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: c.ink,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(clock(ride.arrival), style: numStyle(32, c.ink)),
      ],
    );
  }

  Widget _dash(AppColors c) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(height: 1, color: c.line),
  );
}
