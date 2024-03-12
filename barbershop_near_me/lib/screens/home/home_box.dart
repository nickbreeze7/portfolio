import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mybarbershop/models/place.dart';
import 'package:mybarbershop/utils/providers_home.dart';
import '../../utils/places_notifier2.dart';
import '../../utils/providers_map.dart';
import '../Map/map_screen.dart';

class HomeBox extends ConsumerWidget {
  const HomeBox({super.key});

  //@override
  //_HomeBoxState createState() => _HomeBoxState();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedKm = ref.watch(kilometerProvider);
    print('selectedKm:=====================>>> $selectedKm');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Nearby button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.near_me, size: 24),
                  SizedBox(width: 8),
                  Text('NEARBY'),
                ],
              ),
            ),
            SizedBox(width: 25),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              child:DropdownButtonHideUnderline(
                    child: DropdownButton<double>(
                      value: selectedKm,
                      // newValue ==> value로 변경함. 20240126
                      // home_box.dart에서 하단의 소스들은 문제가 없는거 같음...
                      onChanged: (value) {
                        print('Selected Radius:=====================>>> $value');
                        if (value != null) {
                          ref.read(kilometerProvider.notifier).state = value;
                          ref.read(placesNotifierProvider2.notifier).fetchPlaces(value);
                          print('Selected Radius_value:=====================>>> $value');
                        }
                      },
                      items: [1.0, 3.0, 5.0, 10.0].map<DropdownMenuItem<double>>((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text('$value km'),
                        );
                      }).toList(),
                    ))
            ),

          ],
        ),
      ],
    );
  }
  Future<void> updatePlaces(WidgetRef ref, double radius) async {
    final geoLocatorService = ref.read(geoLocatorServiceProvider);
    try {
      Position currentPosition = await geoLocatorService.getLocation();
      double lat = currentPosition.latitude;
      double lng = currentPosition.longitude;

      ref.read(placesNotifierProvider2.notifier).fetchPlaces7(lat, lng, radius);
    } catch (e) {
      // Handle location fetching errors
      print('Error fetching location: $e');
    }
  }

}

