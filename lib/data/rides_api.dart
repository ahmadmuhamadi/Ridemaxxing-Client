import 'package:flutter/material.dart';

import '../models/ride.dart';

/// Rides heading from [from] to [to] around [time] with at least [seats] free.
///
/// The backend doesn't exist yet, so this returns sample rides. Swap the body
/// for the real request (and `Ride.fromJson`) once the endpoint is up.
Future<List<Ride>> searchRides({
  required String from,
  required String to,
  required TimeOfDay time,
  required int seats,
}) async {
  try {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _sampleRides.where((r) => r.seatsLeft >= seats).toList();
  } catch (e) {
    debugPrint('[RideMaxxing] Searching rides failed: $e');
    rethrow;
  }
}

const _sampleRides = [
  Ride(
    id: 'r1',
    departure: TimeOfDay(hour: 7, minute: 45),
    arrival: TimeOfDay(hour: 8, minute: 20),
    pickup: 'Maple Ave and 5th',
    dropoff: 'City Hall',
    driverName: 'Sara K.',
    rating: 4.9,
    car: 'Toyota Corolla',
    seatsLeft: 2,
    price: 6,
    instantBook: true,
    womanDriver: true,
  ),
  Ride(
    id: 'r2',
    departure: TimeOfDay(hour: 7, minute: 55),
    arrival: TimeOfDay(hour: 8, minute: 35),
    pickup: 'Oak St station',
    dropoff: 'Market Square',
    driverName: 'Omar M.',
    rating: 4.7,
    car: 'Hyundai Elantra',
    seatsLeft: 1,
    price: 5,
    instantBook: true,
    petsOk: true,
  ),
  Ride(
    id: 'r3',
    departure: TimeOfDay(hour: 8, minute: 0),
    arrival: TimeOfDay(hour: 8, minute: 40),
    pickup: 'Maple Ave library',
    dropoff: 'City Hall',
    driverName: 'Jesse B.',
    rating: 4.8,
    car: 'Ford Ranger',
    seatsLeft: 3,
    price: 5,
    petsOk: true,
  ),
  Ride(
    id: 'r4',
    departure: TimeOfDay(hour: 8, minute: 15),
    arrival: TimeOfDay(hour: 8, minute: 45),
    pickup: 'Your door',
    dropoff: 'Downtown office',
    driverName: 'Lina R.',
    rating: 5.0,
    car: 'Honda Civic',
    seatsLeft: 1,
    price: 9,
    instantBook: true,
    womanDriver: true,
  ),
  Ride(
    id: 'r5',
    departure: TimeOfDay(hour: 8, minute: 30),
    arrival: TimeOfDay(hour: 9, minute: 5),
    pickup: 'Pine St and 2nd',
    dropoff: 'Central Station',
    driverName: 'Marco D.',
    rating: 4.6,
    car: 'Kia Niro',
    seatsLeft: 2,
    price: 4,
  ),
];
