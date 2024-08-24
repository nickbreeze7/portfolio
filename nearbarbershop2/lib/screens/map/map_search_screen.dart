import 'dart:async';
import 'dart:developer' as developer;

import 'dart:math' as math;


import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/barbershop.dart';
import '../../services/api_service.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  _MapSearchScreenState createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  NaverMapController? _mapController;
  NLatLng? _currentPosition;
  List<NMarker> _markers = [];
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  final ApiService _apiService = ApiService();
  List<Barbershop> _barbershops = [];
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initialize();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await NaverMapSdk.instance.initialize(
        clientId: '4b3rx4jtw6',
        onAuthFailed: (e) => developer.log('Map Auth Failed: $e'),
      );

      PermissionStatus status = await Permission.locationWhenInUse.request();
      if (status.isGranted) {
        developer.log('Location Permission Granted');
        await _getCurrentLocation();
      } else if (status.isPermanentlyDenied) {
        developer.log('Location Permission Permanently Denied. Please enable it from settings.');
      } else {
        developer.log('Location Permission Denied');
      }
    } catch (e) {
      developer.log('Initialization Error: ${e.toString()}');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      developer.log("Current location: ${position.latitude}, ${position.longitude}");
      setState(() {
        _currentPosition = NLatLng(position.latitude, position.longitude);
      });

      if (_mapController != null && _currentPosition != null) {
        _mapController!.updateCamera(NCameraUpdate.fromCameraPosition(
          NCameraPosition(target: _currentPosition!, zoom: 14.0),
        ));
        await _loadBarbershops(position.latitude, position.longitude);  // Pass current location
      }
    } catch (e) {
      developer.log('Error getting current location: ${e.toString()}');
    }
  }

 

  Future<void> _loadBarbershops(double latitude, double longitude) async {

    try {
      developer.log('Loading barbershops...');
      Position position = await _determinePosition();
      List<Barbershop> barbershops = await _apiService.getBarbershops(position.latitude, position.longitude);

      // Ensure the data is sorted by proximity
      barbershops.sort((a, b) => _calculateDistance(latitude, longitude, a.y, a.x)
          .compareTo(_calculateDistance(latitude, longitude, b.y, b.x)));

      developer.log('Barbershops loaded and sorted: $barbershops');
      setState(() {
        _barbershops = barbershops;
      });

      // Creating markers directly from the list of barbershops
      List<NMarker> markers = barbershops.map((Barbershop shop) {
        return NMarker(
          id: shop.id.toString(),
          position: NLatLng(shop.y, shop.x),
          caption: NOverlayCaption(
            text: shop.name,
            color: Colors.blue,
            textSize: 20.0,
          ),
        );
      }).toList();

      if (_mapController != null) {
        developer.log("Adding markers to the map");
        for (NMarker marker in markers) {
          _mapController!.addOverlay(marker);  // Add each marker to the map
        }
      }
    } catch (e) {
      developer.log('Error fetching barbershops: $e');
    }
  }
  
  /*
  void _loadBarbershops99999() async {
    try {
      Position position = await _determinePosition();
      final barbershops = await _apiService.getBarbershops(position.latitude, position.longitude);
      setState(() {
        _markers = barbershops.map<NMarker>((barbershop) {
          return NMarker(
            id: barbershop.id.toString(),
            position: NLatLng(barbershop.latitude, barbershop.longitude),
            captionText: barbershop.name,
            captionColor: Colors.blue,
            onTap: (NMarker marker, Map<String, int> info) {
              // Define what happens when a marker is tapped
              print('Tapped on: ${barbershop.name}');
            },
          );
        }).toList();
      });
      _controller.addOverlayAll(_markers); // Add markers to the map
    } catch (e) {
      print('Error loading barbershops: $e');
    }
  }
*/

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    // Simple Haversine formula to calculate distance between two points on the Earth
    const R = 6371e3; // Earth's radius in meters
    double phi1 = lat1 * (math.pi / 180);
    double phi2 = lat2 * (math.pi / 180);
    double deltaPhi = (lat2 - lat1) * (math.pi / 180);
    double deltaLambda = (lon2 - lon1) * (math.pi / 180);

    double a = math.sin(deltaPhi / 2) * math.sin(deltaPhi / 2) +
        math.cos(phi1) * math.cos(phi2) *
            math.sin(deltaLambda / 2) * math.sin(deltaLambda / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c; // Distance in meters
  }

Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : NaverMap(
              onMapReady: (NaverMapController controller) {
                _mapController = controller;
                mapControllerCompleter.complete(controller);
                developer.log("onMapCreated");

                if (_currentPosition != null) {
                  _mapController!.updateCamera(NCameraUpdate.fromCameraPosition(
                    NCameraPosition(target: _currentPosition!, zoom: 14.0),
                  ));
                }
                _loadBarbershops(_currentPosition!.latitude, _currentPosition!.longitude);  // Ensure markers load
              },
              options: NaverMapViewOptions(
                indoorEnable: true,
                locationButtonEnable: true,
                zoomGesturesEnable: true,
              ),
            ),
            if (_barbershops.isNotEmpty)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 170,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _barbershops.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentIndex = index;
                      });
                      var lat = _barbershops[index].y;
                      var lng = _barbershops[index].x;

                      if (lat != null && lng != null) {
                        var newPosition = NLatLng(lat, lng);
                        var newCameraPosition = NCameraPosition(target: newPosition, zoom: 17);
                        _mapController?.updateCamera(NCameraUpdate.fromCameraPosition(newCameraPosition));
                      }

                      // Jump back to the first item if last item is reached
                      if (index == _barbershops.length - 1) {
                        Future.delayed(Duration(milliseconds: 300), () {
                          _pageController?.jumpToPage(0);
                        });
                      }
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Barbershop shop = _barbershops[index];
                      return GestureDetector(
                        onTap: () {
                          var newPosition = NLatLng(shop.y, shop.x);
                          _mapController?.updateCamera(NCameraUpdate.fromCameraPosition(
                            NCameraPosition(target: newPosition, zoom: 17),
                          ));
                          // Optionally, interact with the marker here
                        },
                        child: Transform.scale(
                          scale: index == _currentIndex ? 1 : 0.9,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.5, 0.5),
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                              child: Row(
                                children: [
                                  shop.thumUrl == null || shop.thumUrl.isEmpty
                                      ? Image.asset(
                                    'assets/barbershop02.jpg',  // Default image if thumUrl is null or empty
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.network(
                                    shop.thumUrl,  // Use the thumUrl if it's valid
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Expanded(  // Wrap shop.name in Expanded to ensure it takes only available space
                                                child: Text(
                                                  shop.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  overflow: TextOverflow.ellipsis, // Handle long names
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8), // Add spacing between name and bizhourInfo
                                            Text(
                                              shop.bizhourInfo,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                              overflow: TextOverflow.ellipsis, // Handle long bizhourInfo
                                            ),
                                          ],
                                        ),
                                        Text(
                                          shop.address,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis, // Handle long addresses
                                        ),
                                        Text(
                                          shop.tel,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis, // Handle long tel numbers
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )

                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
