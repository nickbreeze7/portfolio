import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mybarbershop/utils/providers_home.dart';

import '../models/place.dart';
import '../services/geolocator_service.dart';
import '../services/marker_service.dart';
import '../services/places_service.dart';


// GeoLocatorService : 소스가 있음. 20231210.
// PlacesService : 소스가 있음. 20231210.

final placesServiceProvider = Provider<PlacesService>((ref) => PlacesService());
final geoLocatorServiceProvider = Provider<GeoLocatorService>((ref) => GeoLocatorService());

// 원본 => 이걸로 하니까, 여기 위도경도로는 데이터가 안나옴.
final currentPositionProvider = FutureProvider<Position?>((ref) async {
  return ref.read(geoLocatorServiceProvider).getLocation();  // 이건 로직이 맞음!!.
});

final placesProvider7 = FutureProvider<List<Place>>((ref) async {
  final radius = ref.watch(kilometerProvider);
  final position = await ref.watch(currentPositionProvider.future);

  if (position != null) {
    final placesService = ref.read(placesServiceProvider);
    return await placesService.getPlaces(position.latitude, position.longitude, radius * 1000);
  } else {
    return [];
  }
});

// FutureProvider.family : 이 코드가 작동을 안함!!
final placesProvider2 = FutureProvider.family<List<Place>, double>((ref, radius) async {
  // 밑에 로직때문에  place.dart에서 Kilo마다 데이터 조회가 가능해짐!!
  final position = await ref.watch(currentPositionProvider.future);
  // final position = await currentPositionProvider;
  print('placesProvider2_radius:=====================>>> $radius');
  print('placesProvider2_position:=====================>>> $position');

  if (position != null) {
    print('1111111111111111');
    final placesService = ref.read(placesServiceProvider);
    print('placesProvider2_placesService:=====================>>> $placesService');
    return await placesService.getPlaces(position.latitude, position.longitude, radius);
  } else{
    print('3333333333333333');
    return [];
  }
  //return  position as List<Place>;  // 이건 로직이 맞음!!., 맞는지 테스트 해봐야 됨.
});

final markersServiceProvider = Provider<MarkerService>((ref) => MarkerService());

final markersProvider = Provider<List<Marker>>((ref) {
  final radius = ref.watch(kilometerProvider);
  print('markersProvider_radius:=====================>>> $radius');

  //final places7 = ref.watch(placesProvider2(radius)).asData?.value ?? [];
  final places = ref.watch(placesProvider7).asData?.value ?? [];
  print('markersProvider_places:=====================>>> $places');

 // final markers7 = ref.watch(placesProvider2(radius)).asData?.value ?? [];
  final markers = ref.watch(placesProvider7).asData?.value ?? [];

  print('markersProvider_markers:=====================>>> $markers');

  // Logic to create markers based on places
  //  places => markers
  return ref.read(markersServiceProvider).getMarkers(markers);
  print('markersProvider_markers:=====================>>> $markers');

});




