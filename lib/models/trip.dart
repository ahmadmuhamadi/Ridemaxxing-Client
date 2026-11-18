/// Trip data as it comes from the server.
class UpcomingTrip {
  UpcomingTrip.fromJson(Map<String, dynamic> j)
    : id = j['id'],
      time = j['time'],
      day = j['day'],
      from = j['from'],
      to = j['to'],
      driver = j['driver'],
      initials = j['initials'],
      rating = j['rating'],
      seats = j['seats'],
      price = j['price'],
      confirmed = j['confirmed'] ?? false,
      live = j['live'] ?? false;

  final String id, time, day, from, to, driver, initials, rating, seats, price;
  final bool confirmed, live;
}

class PastTrip {
  PastTrip.fromJson(Map<String, dynamic> j)
    : id = j['id'],
      group = j['group'],
      route = j['route'],
      when = j['when'],
      driver = j['driver'],
      initials = j['initials'],
      price = j['price'],
      rated = j['rated'] ?? 0;

  final String id, group, route, when, driver, initials, price;
  final int rated;
}

class MonthStats {
  MonthStats.fromJson(Map<String, dynamic> j)
    : rides = j['rides'],
      spent = j['spent'],
      saved = j['saved'];

  final String rides, spent, saved;
}
