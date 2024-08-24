import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/barbershop.dart';
import '../../utils/barbershopsProvider.dart';
import 'map_search_screen.dart';


class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //AsyncValue<List<Barbershop>> barbershops = ref.watch(barbershopsProvider);

    return MaterialApp(
      title: '우리동네 바버샾',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*  home: barbershops.when(
        data: (data) => MapSearchScreen(),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),*/
      home: MapSearchScreen(),
    );
  }
}
