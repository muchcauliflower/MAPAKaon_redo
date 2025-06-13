import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'RouteStorage.dart';

class StepByStepRoute {
  final LatLng start;
  final LatLng end;
  final List<StoredRoute> jeepneyRoutes;

  StepByStepRoute({
    required this.start,
    required this.end,
    required this.jeepneyRoutes,
  });

  Future<List<LatLng>> computeStepByStepPath() async {
    final selectedRoute = _findNearestRouteInCorrectDirection(start, end);

    if (selectedRoute == null) {
      throw Exception('No suitable jeepney route found going in the correct direction.');
    }

    final startToJeep = _findClosestPoint(selectedRoute.coordinates, start);
    final startIdx = _findClosestIndex(selectedRoute.coordinates, startToJeep);
    final endIdx = _findClosestIndex(selectedRoute.coordinates, end);

    if (startIdx >= endIdx) {
      throw Exception('End point is before the start on this one-way route.');
    }

    debugPrint('📍 Starting from: $start');
    debugPrint('🛻 Taking route: ${selectedRoute.routeName}');
    debugPrint('🧍 Walking to: $startToJeep');
    debugPrint('🏁 Reached destination via ${selectedRoute.routeName}');
    debugPrint('✅ Step-by-step path has ${endIdx - startIdx + 3} points');

    final stepByStep = <LatLng>[
      start,
      startToJeep,
      ...selectedRoute.coordinates.sublist(startIdx, endIdx + 1),
      end
    ];

    return stepByStep;
  }

  StoredRoute? _findNearestRouteInCorrectDirection(LatLng start, LatLng end) {
    StoredRoute? bestRoute;
    double minDistance = double.infinity;

    for (final route in jeepneyRoutes) {
      final startIdx = _findClosestIndex(route.coordinates, start);
      final endIdx = _findClosestIndex(route.coordinates, end);

      // Ensure direction is valid
      if (startIdx < endIdx) {
        final startDist = const Distance().as(LengthUnit.Meter, start, route.coordinates[startIdx]);
        final endDist = const Distance().as(LengthUnit.Meter, end, route.coordinates[endIdx]);
        final totalDist = startDist + endDist;

        if (totalDist < minDistance) {
          minDistance = totalDist;
          bestRoute = route;
        }
      }
    }

    return bestRoute;
  }

  int _findClosestIndex(List<LatLng> points, LatLng target) {
    int closestIndex = 0;
    double minDist = double.infinity;

    for (int i = 0; i < points.length; i++) {
      final d = const Distance().as(LengthUnit.Meter, target, points[i]);
      if (d < minDist) {
        minDist = d;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  LatLng _findClosestPoint(List<LatLng> points, LatLng target) {
    return points[_findClosestIndex(points, target)];
  }
}
