import 'package:flutter/material.dart';

import '../models/ride_history.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'route_marker.dart';

class RideHistoryCard extends StatefulWidget {
  const RideHistoryCard({required this.ride, super.key});

  final RideHistoryItem ride;

  @override
  State<RideHistoryCard> createState() => _RideHistoryCardState();
}

class _RideHistoryCardState extends State<RideHistoryCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final ride = widget.ride;
    return Semantics(
      button: true,
      expanded: _expanded,
      label: '${ride.from} to ${ride.to}, ${_date(ride.departureAt)}',
      child: GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        behavior: HitTestBehavior.opaque,
        child: Glass(
          padding: const EdgeInsets.all(16),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CardHeader(ride: ride, expanded: _expanded),
                const SizedBox(height: 14),
                _RouteSummary(ride: ride, expanded: _expanded),
                const SizedBox(height: 14),
                if (ride case PassengerRide passenger)
                  _PassengerSummary(ride: passenger)
                else if (ride case DriverRide drive)
                  _DriverSummary(ride: drive),
                if (_expanded) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(height: 1, color: c.line),
                  ),
                  if (ride case PassengerRide passenger)
                    _PassengerDetails(ride: passenger)
                  else if (ride case DriverRide drive)
                    _DriverDetails(ride: drive),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.ride, required this.expanded});

  final RideHistoryItem ride;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Icon(Icons.calendar_today_outlined, size: 16, color: c.gold),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            '${_date(ride.departureAt)}  •  '
            '${_clock(context, ride.departureAt)}–${_clock(context, ride.arrivalAt)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: c.muted,
            ),
          ),
        ),
        AnimatedRotation(
          turns: expanded ? .5 : 0,
          duration: const Duration(milliseconds: 220),
          child: Icon(Icons.expand_more, color: c.muted),
        ),
      ],
    );
  }
}

class _RouteSummary extends StatelessWidget {
  const _RouteSummary({required this.ride, required this.expanded});

  final RideHistoryItem ride;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: RouteMarker(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RouteStop(
                  label: 'FROM',
                  location: ride.from,
                  address: ride.pickupAddress,
                  expanded: expanded,
                ),
                const SizedBox(height: 14),
                _RouteStop(
                  label: 'TO',
                  location: ride.to,
                  address: ride.dropoffAddress,
                  expanded: expanded,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              _money(switch (ride) {
                PassengerRide r => r.farePaid,
                DriverRide r => r.totalEarnings,
                _ => 0,
              }),
              style: numStyle(25, c.ink),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStop extends StatelessWidget {
  const _RouteStop({
    required this.label,
    required this.location,
    required this.address,
    required this.expanded,
  });

  final String label;
  final String location;
  final String address;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: c.muted,
            letterSpacing: .7,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          location,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: c.ink,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          address,
          maxLines: expanded ? null : 1,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, height: 1.25, color: c.muted),
        ),
      ],
    );
  }
}

class _PassengerSummary extends StatelessWidget {
  const _PassengerSummary({required this.ride});

  final PassengerRide ride;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        _Avatar(name: ride.driverName),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ride.driverName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: c.ink,
                ),
              ),
              Text(
                'Driver  •  ★ ${ride.driverRating.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 12, color: c.gold),
              ),
            ],
          ),
        ),
        _StatusBadge(status: ride.status),
      ],
    );
  }
}

class _DriverSummary extends StatelessWidget {
  const _DriverSummary({required this.ride});

  final DriverRide ride;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        Icon(Icons.people_outline, size: 20, color: c.primary),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            '${ride.occupiedSeats}/${ride.seatCapacity} Passengers',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: c.ink,
            ),
          ),
        ),
        _StatusBadge(status: ride.status),
      ],
    );
  }
}

class _PassengerDetails extends StatelessWidget {
  const _PassengerDetails({required this.ride});

  final PassengerRide ride;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle('Vehicle details'),
        const SizedBox(height: 10),
        _VehicleSummary(vehicle: ride.vehicle),
        const SizedBox(height: 16),
        const _SectionTitle('Trip breakdown'),
        const SizedBox(height: 8),
        _DetailRow(label: 'Payment', value: ride.paymentMethod),
        _DetailRow(label: 'Ride reference', value: ride.id),
        _DetailRow(
          label: 'Status',
          value: _statusLabel(ride.status),
          bottomPadding: 0,
        ),
      ],
    );
  }
}

class _DriverDetails extends StatelessWidget {
  const _DriverDetails({required this.ride});

  final DriverRide ride;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle('Passengers'),
        const SizedBox(height: 8),
        for (var i = 0; i < ride.passengers.length; i++) ...[
          _PassengerRow(passenger: ride.passengers[i]),
          if (i != ride.passengers.length - 1) const SizedBox(height: 8),
        ],
        const SizedBox(height: 18),
        const _SectionTitle('Ride & vehicle'),
        const SizedBox(height: 10),
        _VehicleSummary(vehicle: ride.vehicle),
        const SizedBox(height: 12),
        _DetailRow(label: 'Price per seat', value: _money(ride.pricePerSeat)),
        _DetailRow(label: 'Distance', value: '${ride.distanceKm} km'),
        _DetailRow(label: 'Duration', value: '${ride.durationMinutes} min'),
        _DetailRow(label: 'Ride reference', value: ride.id),
        _DetailRow(
          label: 'Status',
          value: _statusLabel(ride.status),
          bottomPadding: 0,
        ),
      ],
    );
  }
}

class _VehicleSummary extends StatelessWidget {
  const _VehicleSummary({required this.vehicle});

  final VehicleInfo vehicle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.line,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.directions_car_outlined, color: c.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle.displayName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: c.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  vehicle.color,
                  style: TextStyle(fontSize: 12, color: c.muted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: c.line),
            ),
            child: Text(
              vehicle.licensePlate,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
                color: c.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassengerRow extends StatelessWidget {
  const _PassengerRow({required this.passenger});

  final RidePassenger passenger;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final seats =
        '${passenger.seatCount} seat${passenger.seatCount == 1 ? '' : 's'}';
    return Row(
      children: [
        _Avatar(name: passenger.name, small: true),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                passenger.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: c.ink,
                ),
              ),
              Text(
                '$seats  •  ${passenger.status}',
                style: TextStyle(fontSize: 12, color: c.muted),
              ),
            ],
          ),
        ),
        Text(_money(passenger.fare), style: numStyle(19, c.ink)),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name, this.small = false});

  final String name;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final parts = name.trim().split(' ');
    final initials = parts.take(2).map((part) => part[0]).join();
    return CircleAvatar(
      radius: small ? 17 : 20,
      backgroundColor: c.primarySoft,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: small ? 11 : 13,
          fontWeight: FontWeight.w700,
          color: c.primary,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final RideHistoryStatus status;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final completed = status == RideHistoryStatus.completed;
    final color = completed ? c.primary : c.danger;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Text(
        _statusLabel(status),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Text(
      text,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: c.ink),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.bottomPadding = 7,
  });

  final String label;
  final String value;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 13, color: c.muted)),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: c.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _statusLabel(RideHistoryStatus status) => switch (status) {
  RideHistoryStatus.completed => 'Completed',
  RideHistoryStatus.cancelled => 'Cancelled',
};

String _money(double amount) {
  final value = amount == amount.roundToDouble()
      ? amount.toStringAsFixed(0)
      : amount.toStringAsFixed(2);
  return 'EGP $value';
}

String _date(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[value.month - 1]} ${value.day}, ${value.year}';
}

String _clock(BuildContext context, DateTime value) =>
    MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(value),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
