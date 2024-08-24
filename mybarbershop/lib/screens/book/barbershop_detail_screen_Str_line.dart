import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/place.dart';
import '../../services/getTodayHours.dart';




class BarbershopDetailScreenStrline extends ConsumerWidget {
  final String placeId; // Assume we are passing the placeId to find the place in the provider

  const BarbershopDetailScreenStrline({Key? key, required this.placeId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // You can use ref to watch providers and access data

    // Handle loading and error states before trying to access the data
    final placesAsyncValue = ref.watch(placesProvider);

    return placesAsyncValue.when(
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
      data: (places) {
        // Once the data is available, find the place by placeId
        final Place place = places.firstWhere(
              (place) => place.placeId == placeId,
          orElse: () => null as Place, // This is now valid since place is declared as Place?
        );

        // If place is not found, return an error message
        if (place == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Place not found'),
            ),
            body: Center(
              child: Text('Could not find the place details'),
            ),
          );
        }

        // If place is found, build the detail screen
        return Scaffold(
          appBar: AppBar(
            //title: Text(place.name),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white,
              size: 40,
            ),
          ),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image header
                Image.network(
                  buildPhotoURL(place.photos![0].photoReference),
                  height: 300,
                  fit: BoxFit.cover,
                ),
                // Rating and other details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: Column(
                          children: <Widget>[
                            Text(
                              place.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            RatingBarIndicator(
                              rating: place.rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 25.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 8),
                            // Address and operating hours
                            Text(place.vicinity),
                            Text(
                              '${place.openingHours?.openNow != false ? '영업 중' : '영업종료'} | ${getTodayHours(place.openingHours!.weekdayText!)}',
                            ),
                            SizedBox(height: 8),

                            // Services Section
                            // Add service icons and labels here
                            // Gallery Section
                            // Add gallery images here
                            // Reviews Section
                            // Add reviews here
                            // About Section
                            // Add about details here
                            // Location Section
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Book Now button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColorDark,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Implement booking logic
                    },
                    child: Text('Book Now'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
