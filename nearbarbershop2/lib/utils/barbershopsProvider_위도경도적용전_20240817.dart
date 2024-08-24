

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/barbershop.dart';
import '../services/api_service.dart';

final barbershopsProvider999 = FutureProvider<List<Barbershop>>((ref ) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getBarbershops( 37.5665, 126.9780);
});



final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

