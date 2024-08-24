import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/barbershop.dart';
import '../../utils/barbershopsProvider.dart';

class MapSearchScreen extends ConsumerWidget {
  const MapSearchScreen({Key? key, data}) : super(key: key);

  // Default coordinates for New York City
  static const double defaultLat = 35.237105;
  static const double defaultLng = 128.581661;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Barbershop>> barbershops = ref.watch(barbershopsProvider);
    //LatLng position = LatLng(shop.x, shop.y);
    return barbershops.when(
      data: (barbershops) {
        Set<Marker> markers = barbershops.map((shop) => Marker(
          markerId: MarkerId('${shop.id}'),
          position: LatLng(shop.x, shop.y),
          infoWindow: InfoWindow(title: shop.name, snippet: shop.address),
        )).toSet();

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            // Check if list is empty and provide a fallback position
            target: barbershops.isNotEmpty
                ? LatLng(barbershops[0].x, barbershops[0].y)
                : LatLng(defaultLat, defaultLng), // Provide default coordinates
            zoom: 12,
          ),
          markers: markers,
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}