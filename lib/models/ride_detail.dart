/// One ride offer as it comes from the server.
class RideDetail {
  RideDetail.fromJson(Map<String, dynamic> j)
    : driver = j['driver'],
      initials = j['initials'],
      rating = j['rating'],
      driverRides = j['driverRides'],
      verified = j['verified'] ?? false,
      summary = j['summary'],
      pickup = RideStop.fromJson(j['pickup']),
      dropoff = RideStop.fromJson(j['dropoff']),
      car = j['car'],
      seatsLeft = j['seatsLeft'],
      booking = j['booking'],
      instant = j['instant'] ?? false,
      rules = List<String>.from(j['rules'] ?? []),
      reviews = [for (final r in j['reviews'] ?? []) RideReview.fromJson(r)],
      price = j['price'];

  final String driver, initials, rating, driverRides, summary;
  final String car, seatsLeft, booking, price;
  final bool verified, instant;
  final RideStop pickup, dropoff;
  final List<String> rules;
  final List<RideReview> reviews;
}

class RideStop {
  RideStop.fromJson(Map<String, dynamic> j)
    : time = j['time'],
      place = j['place'],
      note = j['note'];

  final String time, place, note;
}

class RideReview {
  RideReview.fromJson(Map<String, dynamic> j)
    : stars = j['stars'],
      name = j['name'],
      when = j['when'],
      text = j['text'];

  final int stars;
  final String name, when, text;
}
