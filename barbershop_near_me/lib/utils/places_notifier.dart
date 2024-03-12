import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybarbershop/models/place.dart';
import 'package:mybarbershop/services/places_service.dart';
import 'package:mybarbershop/utils/providers_map.dart';

import '../services/geolocator_service.dart';

class PlacesState {
  final bool isLoading;
  final List<Place>? places;
  final String? errorMessage;

  PlacesState({this.isLoading = false, this.places, this.errorMessage});

  /*PlacesState copyWith({bool? isLoading, List<Place>? places, String? errorMessage}) {
    return PlacesState(
      isLoading: isLoading ?? this.isLoading,
      places: places ?? this.places,
      errorMessage: errorMessage ?? this.errorMessage,
    );*/

  PlacesState.loading() : isLoading = true, places = null, errorMessage = null;
  PlacesState.data(List<Place> places) : isLoading = false, places = places, errorMessage = null;
  PlacesState.error(String message) : isLoading = false, places = null, errorMessage = message;
}
class PlacesNotifier extends StateNotifier<PlacesState> {
  final PlacesService _placesService;
  final GeoLocatorService _geoLocatorService;

  PlacesNotifier(this._placesService, this._geoLocatorService) : super(PlacesState());

  Future<void> fetchPlaces(double radius) async {
    state = PlacesState.loading();
    try {
      final currentPosition = await _geoLocatorService.getLocation();
      final lat = currentPosition.latitude;
      final lng = currentPosition.longitude;
      final places = await _placesService.getPlaces(lat, lng, radius);
      state = PlacesState.data(places);
    } catch (e) {
      state = PlacesState.error(e.toString());
    }
  }
}

/*final placesNotifierProvider999 = StateNotifierProvider<PlacesNotifier, PlacesState>((ref) {
  return PlacesNotifier(ref.read(placesServiceProvider));
});*/

final placesNotifierProvider = StateNotifierProvider<PlacesNotifier, PlacesState>((ref) {
  final placesService = ref.read(placesServiceProvider);
  final geoLocatorService = ref.read(geoLocatorServiceProvider);
  return PlacesNotifier(placesService, geoLocatorService);
});
