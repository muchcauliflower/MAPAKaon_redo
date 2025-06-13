import 'package:latlong2/latlong.dart';

class StoredRoute {
  final String routeName;
  final List<LatLng> coordinates;

  StoredRoute({required this.routeName, required this.coordinates});

  Map<String, dynamic> toJson() => {
    'routeName': routeName,
    'coordinates': coordinates
        .map((latlng) => {'lat': latlng.latitude, 'lng': latlng.longitude})
        .toList(),
  };

  factory StoredRoute.fromJson(Map<String, dynamic> json) {
    List<dynamic> coords = json['coordinates'];
    return StoredRoute(
      routeName: json['routeName'],
      coordinates: coords
          .map((point) =>
          LatLng(point['lat'].toDouble(), point['lng'].toDouble()))
          .toList(),
    );
  }
}

List<StoredRoute> storedRoutes = [];
