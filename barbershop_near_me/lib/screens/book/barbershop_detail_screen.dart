import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/place.dart';
import '../../services/getTodayHours.dart';
import '../../services/places_service.dart';
import '../../utils/providers_home.dart';

//void main() => runApp(BarbershopDetailScreen5Tab());

class BarbershopDetailScreen extends ConsumerWidget {
  final String placeId; // Assume we are passing the placeId to find the place in the provider

  const BarbershopDetailScreen({Key? key, required this.placeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // You can use ref to watch providers and access data
    // Handle loading and error states before trying to access the data
    final placesAsyncValue = ref.watch(placesProvider);
    final radiusInKm = ref.watch(kilometerProvider); // Watch the state of kilometerProvider
    final radiusInMeters = radiusInKm * 1000; // Convert kilometers to meters


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
          return DefaultTabController(
            length: 2, // Number of tabs
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: _buildImage(context, buildPhotoURL(place.photos![0].photoReference)),
                      ),
                      bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.home), text: '홈'),
                          Tab(icon: Icon(Icons.style), text: '리뷰'),
                         // Tab(icon: Icon(Icons.star), text: '정보'),
                        //  Tab(icon: Icon(Icons.photo_album), text: 'Gallery'),
                        //  Tab(icon: Icon(Icons.person), text: 'Stylists'),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    HomeScreen( place: place),
                  //  ServicesScreen(),
                    ReviewsScreen(placeId: place.placeId),
                   // GalleryScreen(),
                   // StylistsScreen(),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}


Widget _buildImage(BuildContext context, String buildPhotoURL) {
  return Align(
    alignment: Alignment.topCenter,
    child: SizedBox(
      height: 400, // Adjust height as needed
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Your image logic
          Image.network(
            buildPhotoURL,
            fit: BoxFit.fill,
            height: 200, // Adjust as needed
            width: double.infinity,
          ),
          // Simulating the AppBar look
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 56, // Typical AppBar height
              padding: EdgeInsets.symmetric(horizontal: 16), // Common padding
              decoration: BoxDecoration(
                color: Colors.transparent, // Mimicking AppBar's transparent background
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Assuming you want a leading widget like an icon
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 40), // Customizable
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Add more widgets here as needed, like title or actions
                ],
              ),
            ),
          ),
          // If you have other widgets to layer on the image, include them here
        ],
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
   final Place place;
   const HomeScreen({Key? key, required this.place}) : super(key: key); // Add constructor

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: 900,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
            /*  Positioned.fill(
                child: _buildImage(
                    context, buildPhotoURL(place.photos![0].photoReference)),
              ),*/
              _buildContent(context, place),
              //_buildThirteen(context, place),
              //SizedBox(height: 30),
              _buildBookButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildContent(BuildContext context, Place place) {
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
                  padding: EdgeInsets.only(right: 240.0, left: 8.0, bottom: 8.0, top: 8.0),
                  child: Text(
                    place.name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold, // Add this line to set the font weight to bold
                      fontSize: 25.0,
                    ),
                  ),
                ),
               // SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(right: 265.0, left: 1.0, bottom: 8.0, top: 5.0),
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
                //SizedBox(height: 8),
                // Address and operating hours
                Padding(
                  //padding: EdgeInsets.only(right: 240.0, left: 8.0, bottom: 8.0, top: 8.0),
                  padding:EdgeInsets.fromLTRB( 8.0, 8.0, 115.0, 8.0), // (left, top, right,
                  child: Text(place.vicinity),
                ),
                //SizedBox(height: 5),
                Padding(
                  //padding: EdgeInsets.only(right: 150.0),
                  padding:EdgeInsets.fromLTRB( 1.0, 8.0, 125.0, 8.0), // (left, top, right,
                  child: Text(
                    '${place.openingHours?.openNow != false ? '영업 중' : '영업종료'} | ${getTodayHours(place.openingHours!.weekdayText!)}',
                  ),
                ),
                //SizedBox(height: 8),

              ],
            ),
            // Container with fixed height for the button
             SizedBox(height: 30),

          ],
        ),
      ),
    ),
  );
}



Widget _buildBookButton(BuildContext context) {
  return Padding(
    //padding: EdgeInsets.symmetric(horizontal: 6.0),
    padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0, bottom: 50.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize:Size.fromHeight(50),
        primary: Theme.of(context).primaryColorDark,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      //onPressed: () {  },
      onPressed: () {  },
      child: Text('예약하기',
        style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      /*onPressed:(){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>  BookingScreen()));
        //builder: (_) =>  BarbershopDetailScreenBak2()));
        //builder: (_) =>  BarbershopDetailScreenStrline(placeId: places[index].placeId)));

      },*/
    ),
  );
}

/*class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Services Content'));
  }
}*/


class ReviewsScreen extends StatelessWidget {
  final String placeId;

  const ReviewsScreen({
    Key? key,
    required this.placeId,
  }) : super(key: key);

 /* @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: PlacesService().fetchPlaceReviews(placeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Review> reviews = snapshot.data!;
          // Build UI using the reviews data
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(reviews[index].authorName),
                subtitle: Text(reviews[index].text),
                // Add more review details as needed
              );
            },
          );
        } else {
          return Center(child: Text('No reviews available'));
        }
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: PlacesService().fetchPlaceReviews(placeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Review> reviews = snapshot.data!;
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              Review review = reviews[index];
              return Card(
                elevation: 1.0,
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            review.authorName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                              DateTime.fromMillisecondsSinceEpoch(review.time),
                            ),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      RatingBar.builder(
                        initialRating: review.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20.0,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        review.text,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No reviews available'));
        }
      },
    );
  }
}


class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Gallery Content'));
  }
}

class StylistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Stylists Content'));
  }
}
