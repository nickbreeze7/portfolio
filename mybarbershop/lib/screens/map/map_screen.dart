// map_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'map_search_screen.dart';


class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Optionally access providers using ref.watch if needed

    return MaterialApp(
      title: '우리동네 바버샾',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: const MapSearchScreen(), // Pass providers data if needed

    );
  }
}
