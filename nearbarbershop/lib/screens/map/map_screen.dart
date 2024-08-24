// map_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/barbershop.dart';
import '../../utils/barbershopsProvider.dart';




class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Optionally access providers using ref.watch if needed
    //final barbershops = ref.watch(barbershopsProvider);
    AsyncValue<List<Barbershop>> barbershops = ref.watch(barbershopsProvider);

    return MaterialApp(
      title: '우리동네 바버샾',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:  MapSearchScreen(), // Pass providers data if needed
        /*
      home:barbershops.when(
        data: (data) => MapSearchScreen(),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      )
      */

    );
  }
}
