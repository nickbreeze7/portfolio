

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/barbershop.dart';
import '../services/api_service.dart';

final barbershopsProvider = FutureProvider<List<Barbershop>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getBarbershops();
});



final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

