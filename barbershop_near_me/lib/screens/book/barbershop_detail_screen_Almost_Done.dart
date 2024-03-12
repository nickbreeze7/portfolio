import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/place.dart';
import '../../services/getTodayHours.dart';




class BarbershopDetailScreenAlmostDone extends ConsumerWidget {
  final String placeId; // Assume we are passing the placeId to find the place in the provider

  const BarbershopDetailScreenAlmostDone({Key? key, required this.placeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // You can use ref to watch providers and access data

    // Handle loading and error states before trying to access the data
    final placesAsyncValue = ref.watch(placesProvider);

    return placesAsyncValue.when(
        loading: () =>
            Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        error: (error, stack) =>
            Scaffold(
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
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body:
              SizedBox(
                height: 900,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      child: _buildFourteen(context, buildPhotoURL(place.photos![0].photoReference)),
                    ),
                    _buildThirteen(context, place),
                    _buildBookButton( context),
                  ],
                )
              ),
         /*     Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 300, // Adjust the height as needed for _buildFourteen
                    width: double.maxFinite,
                    child: _buildFourteen(context, buildPhotoURL(place.photos![0].photoReference)),
                  ),
                  SizedBox(
                    //height: 400, // Adjust the height as needed for _buildThirteen
                    width: double.maxFinite,
                    child: _buildThirteen(context, place),
                  ),
                ],
              )*/

            ),
          );
        }
    );
  }
}

Widget _buildBookButton(BuildContext context) {
  return Padding(
    //padding: EdgeInsets.symmetric(horizontal: 6.0),
    padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0, bottom: 250.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize:Size.fromHeight(50),
        primary: Theme.of(context).primaryColorDark,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {  },
      child: Text('예약하기',
        style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}


Widget _buildFourteen(BuildContext context, String buildPhotoURL) {
  return Align(
    alignment: Alignment.topCenter,
    child: SizedBox(
      height: 400,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
       /*  CustomImageView(
            Image.network(
              buildPhotoURL,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),*/
          Image.network(
            buildPhotoURL,
            fit: BoxFit.fill,
            height: 200,
            width: double.infinity,
          ),
         /* CustomAppBar(
            leadingWidth: double.maxFinite,
            leading: AppbarLeadingImage(
             // imagePath: ImageConstant.imgIconColor,
              margin: EdgeInsets.fromLTRB(19, 6, 339, 6),
            ),
          ),*/
        ],
      ),
    ),
  );
}


Widget _buildThirteen(BuildContext context, Place place) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0, bottom: 350.0),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
      child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 220.0, left: 8.0, bottom: 8.0, top: 8.0),
                  child: Text(
                    place.name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold, // Add this line to set the font weight to bold
                      fontSize: 25.0,
                    ),
                  ),
                  ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(right: 230.0),
                  child: RatingBarIndicator(
                    rating: place.rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 8),
                // Address and operating hours
                Text(place.vicinity),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(right: 150.0),
                  child: Text(
                    '${place.openingHours?.openNow != false ? '영업 중' : '영업종료'} | ${getTodayHours(place.openingHours!.weekdayText!)}',
                  ),
                ),
                //SizedBox(height: 8),
      
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
            // Container with fixed height for the button
            SizedBox(height: 35),
           /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
                child: Text('예약하기'),
              ),
            ),*/
           /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:Size.fromHeight(50),
                  primary: Theme.of(context).primaryColorDark,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {  },
                child: Text('예약하기',
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),*/
          ],
        ),
      ),
    ),
  );
}
