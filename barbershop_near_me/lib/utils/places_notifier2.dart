import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybarbershop/utils/providers_home.dart';
import 'package:mybarbershop/utils/providers_map.dart';

import '../models/place.dart';
import '../services/geolocator_service.dart';
import '../services/places_service.dart';

class PlacesNotifier2 extends StateNotifier<AsyncValue<List<Place>>> {
  final PlacesService _placesService;
  final GeoLocatorService _geoLocatorService;
  // final double radius;

  PlacesNotifier2(this._placesService, this._geoLocatorService) : super(const AsyncValue.loading());
/* PlacesNotifier2(this._placesService, this.radius, this._geoLocatorService) : super(const AsyncValue.loading()) {
   fetchPlaces7(  ); // Fetch places with initial radius
  }*/

  Future<void> fetchPlaces(double radius) async {
    state = const AsyncValue.loading(); // Indicate loading state
    try {
      //final currentPosition = await _locationService.getLocation();
      final currentPosition = await _geoLocatorService.getLocation();

      final lat = currentPosition.latitude;
      final lng = currentPosition.longitude;

      final places = await _placesService.getPlaces(lat, lng, radius);
      state = AsyncValue.data(places); // Update with fetched data
      print("fetchPlaces_state:>>>>>>>>>>>>>>>>>>>> $state ");
      print("fetchPlaces_places:>>>>>>>>>>>>>>>>>>>> $places ");

    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Handle errors
    }
  }

  Future<void> fetchPlaces7(double lat, double lng, double radius) async {
    try {
      state = AsyncValue.loading();
      List<Place> places = await _placesService.getPlaces(lat, lng, radius);
      state = AsyncValue.data(places);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
final placesNotifierProvider2 = StateNotifierProvider<PlacesNotifier2, AsyncValue<List<Place?>>>(
      (ref) {
    final placesService = ref.read(placesServiceProvider);
    final geoLocatorService = ref.read(geoLocatorServiceProvider);
  //  final radius = ref.read(kilometerProvider);

    return PlacesNotifier2(placesService,  geoLocatorService);
  },
);

/*
final placesNotifierProvider2 = StateNotifierProvider<PlacesNotifier2, AsyncValue<List<Place?>>>(
      (ref) => PlacesNotifier2(
    ref.read(placesServiceProvider),
    ref.read(geoLocatorServiceProvider),
  ),
);*/
