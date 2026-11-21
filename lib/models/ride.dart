import 'package:flutter/material.dart';

class Ride {
  const Ride({
    required this.id,
    required this.departure,
    required this.arrival,
    required this.pickup,
    required this.dropoff,
    required this.driverName,
    required this.rating,
    required this.car,
    required this.seatsLeft,
    required this.price,
    this.instantBook = false,
    this.petsOk = false,
    this.womanDriver = false,
  });

  final String id;
  final TimeOfDay departure, arrival;
  final String pickup, dropoff;
  final String driverName;
  final double rating;
  final String car;
  final int seatsLeft;
  final int price;
  final bool instantBook, petsOk, womanDriver;

  int get _depMinutes => departure.hour * 60 + departure.minute;

  /// Minutes from departure to arrival, wrapping past midnight.
  int get durationMinutes =>
      (arrival.hour * 60 + arrival.minute - _depMinutes) % (24 * 60);

  int compareByDeparture(Ride other) => _depMinutes - other._depMinutes;

  String get initials => driverName
      .split(' ')
      .where((p) => p.isNotEmpty)
      .take(2)
      .map((p) => p[0].toUpperCase())
      .join();

  factory Ride.fromJson(Map<String, dynamic> json) {
    TimeOfDay time(String s) {
      final [h, m] = s.split(':').map(int.parse).toList();
      return TimeOfDay(hour: h, minute: m);
    }

    return Ride(
      id: json['id'] as String,
      departure: time(json['departure'] as String),
      arrival: time(json['arrival'] as String),
      pickup: json['pickup'] as String,
      dropoff: json['dropoff'] as String,
      driverName: json['driverName'] as String,
      rating: (json['rating'] as num).toDouble(),
      car: json['car'] as String,
      seatsLeft: json['seatsLeft'] as int,
      price: json['price'] as int,
      instantBook: json['instantBook'] as bool? ?? false,
      petsOk: json['petsOk'] as bool? ?? false,
      womanDriver: json['womanDriver'] as bool? ?? false,
    );
  }
}

/// "7:45" style clock time, no AM/PM.
String clock(TimeOfDay t) =>
    '${t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod}:${t.minute.toString().padLeft(2, '0')}';
