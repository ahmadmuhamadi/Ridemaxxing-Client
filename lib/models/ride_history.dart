enum RideHistoryStatus { completed, cancelled }

class VehicleInfo {
  const VehicleInfo({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
  });

  final String make;
  final String model;
  final int year;
  final String color;
  final String licensePlate;

  String get displayName => '$make $model $year';
}

abstract class RideHistoryItem {
  const RideHistoryItem({
    required this.id,
    required this.from,
    required this.to,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.departureAt,
    required this.arrivalAt,
    required this.status,
    required this.vehicle,
  });

  final String id;
  final String from;
  final String to;
  final String pickupAddress;
  final String dropoffAddress;
  final DateTime departureAt;
  final DateTime arrivalAt;
  final RideHistoryStatus status;
  final VehicleInfo vehicle;
}

class PassengerRide extends RideHistoryItem {
  const PassengerRide({
    required super.id,
    required super.from,
    required super.to,
    required super.pickupAddress,
    required super.dropoffAddress,
    required super.departureAt,
    required super.arrivalAt,
    required super.status,
    required super.vehicle,
    required this.driverName,
    required this.driverRating,
    required this.farePaid,
    required this.paymentMethod,
  });

  final String driverName;
  final double driverRating;
  final double farePaid;
  final String paymentMethod;
}

class RidePassenger {
  const RidePassenger({
    required this.name,
    required this.seatCount,
    required this.fare,
    this.status = 'Rode',
  });

  final String name;
  final int seatCount;
  final double fare;
  final String status;
}

class DriverRide extends RideHistoryItem {
  const DriverRide({
    required super.id,
    required super.from,
    required super.to,
    required super.pickupAddress,
    required super.dropoffAddress,
    required super.departureAt,
    required super.arrivalAt,
    required super.status,
    required super.vehicle,
    required this.passengers,
    required this.seatCapacity,
    required this.pricePerSeat,
    required this.totalEarnings,
    required this.distanceKm,
  });

  final List<RidePassenger> passengers;
  final int seatCapacity;
  final double pricePerSeat;
  final double totalEarnings;
  final double distanceKm;

  int get occupiedSeats =>
      passengers.fold(0, (sum, item) => sum + item.seatCount);
  int get durationMinutes => arrivalAt.difference(departureAt).inMinutes;
}
