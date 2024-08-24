import 'dart:developer';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/barbershop.dart';
import '../services/api_service.dart';

// Updated barbershopsProvider to accept latitude and longitude
final barbershopsProvider = FutureProvider.family<List<Barbershop>, NLatLng>((ref, position) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getBarbershops(position.latitude, position.longitude);
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
