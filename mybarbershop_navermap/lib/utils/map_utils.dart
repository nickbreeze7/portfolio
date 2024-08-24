import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/barbershop.dart';

class MapUtils {
  static LatLng calculateCenter(List<Barbershop> barbershops) {
    // Define a fallback location in case there are no barbershops
    if (barbershops.isEmpty) {
      // Return Seoul coordinates as the fallback if no barbershops are available
      return LatLng(37.5665, 126.9780);
    }

    double totalX = 0;
    double totalY = 0;

    // Accumulate all coordinates
    for (var shop in barbershops) {
      totalX += shop.x;  // Assuming shop.x is latitude
      totalY += shop.y;  // Assuming shop.y is longitude
    }

    // Calculate the average latitude and longitude
    return LatLng(totalX / barbershops.length, totalY / barbershops.length);
  }
}
