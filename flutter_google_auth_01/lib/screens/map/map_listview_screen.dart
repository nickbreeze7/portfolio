import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/marker_service.dart';

class MapListviewScreen extends StatelessWidget {
  // const MapListviewScreen extends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPosition =
        Provider.of<Position?>(context); // Position에 ?를 하니까, 로딩할 때 에러가 발생안함!!
    final placesProvider =
        Provider.of<Future<List<Place>>?>(context, listen: false);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      initialData: null,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>?>(
                /* child: ElevatedButton(
                    child: Text('메인화면으로'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),*/
                builder: (_, places, __) {
                  /* var markers;
                  if ((places != null)) {
                    markers = markerService.getMarkers(places);
                  } else {
                    markers = <Marker>[];
                  }*/
                  // if ((places != null)) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: ElevatedButton(
                            child: Text('지도화면으로'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      /* SizedBox(
                        height: 2.0,
                      ),*/
                      Expanded(
                        child: ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            itemCount: places!.length,
                            itemBuilder: (context, index) {
                              return FutureProvider(
                                create: (context) => geoService.getDistance(
                                    currentPosition.latitude,
                                    currentPosition.longitude,
                                    places[index].geometry.location.lat,
                                    places[index].geometry.location.lng),
                                initialData: null,
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      places[index].name,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        (places[index].rating != null)
                                            ? Row(
                                                children: <Widget>[
                                                  RatingBarIndicator(
                                                    rating:
                                                        places[index].rating,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Icon(Icons.star,
                                                            color:
                                                                Colors.amber),
                                                    itemCount: 5,
                                                    itemSize: 10.0,
                                                    direction: Axis.horizontal,
                                                  )
                                                ],
                                              )
                                            : Row(),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Consumer<double?>(builder:
                                            (context, kilometers, widget) {
                                          return (kilometers != null)
                                              ? Text(
                                                  // 일단  miles로 나타내고 , 추후에 킬로미터로 바꿈.
                                                  // '${places[index].vicinity}\u00b7 ${(meters / 1609).round()} mi')
                                                  '${places[index].vicinity}\u00b7 ${(kilometers / 1000).round()} km')
                                              : Container();
                                        })
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.directions),
                                      color: Theme.of(context).primaryColor,
                                      // onPressed 누르면  예약하기로 넘어가기
                                      // markerService에  InfoWindow에 화면 크게 해서
                                      // 웬만한 정보 다 담기
                                      onPressed: () {
                                        /* _launchMapsUrl(
                                        places[index]
                                            .geometry
                                            .location
                                            .lat,
                                        places[index]
                                            .geometry
                                            .location
                                            .lng);*/
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                  /* } else {
                    return Center(child: CircularProgressIndicator());
                  }*/
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
