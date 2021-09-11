import 'dart:async';
import 'package:bindoo/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';




class AddAddressPage extends StatefulWidget {

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  Position _position;
  StreamSubscription<Position> _positionStream;
  Address _address;
  String addr1="";
  String addr2="";
  TextEditingController receiverName = new TextEditingController();
  TextEditingController receiverPhone = new TextEditingController();
  TextEditingController receiverAddress = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
   initState()  {
    super.initState();

   getAddressBasedOnLocation();


  }
  getAddressBasedOnLocation() async{

    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      addr1 =addresses.first.featureName;
      addr2 =addresses.first.addressLine;

    });
  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _positionStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: new Text("Add Address",style: TextStyle(color: Colors.white),),

      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: new Card(
            child: new Container(
              width: double.infinity,
              margin: new EdgeInsets.only(left: 20.0, right: 20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  new SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: receiverName,
                    validator: (value) =>
                    value.isEmpty ? 'Name cannot be blank' : null,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.teal)),
                      hintText: "Full Name",
                      labelText: 'Full Name',
                      prefixIcon: const Icon(
                        Icons.account_box,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: receiverPhone,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    value.isEmpty ? 'Phone cannot be blank' : null,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.grey)),
                      hintText: "Phone",
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  new SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(

                    controller: receiverAddress,
                    validator: (value) => value.isEmpty
                        ? 'Address cannot be blank'
                        : null,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.grey)),
                      hintText: "Address",
                      labelText: "Address",
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  new SizedBox(
                    height: 10.0,
                  ),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
  children: [
    RaisedButton(
        color: Colors.white,
        child: Text("Generate Address"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        textColor: Colors.pink,
        onPressed: (){
setState(() {
  receiverAddress = receiverAddress..text=addr2;
});

        }),
    RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text("Save Address"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).primaryColor)),
        textColor: Colors.white,
        onPressed: (){
        if(_formKey.currentState.validate()){
          BindooApp.firestore.collection(BindooApp.collectionUser).document(BindooApp.sharedPreferences.getString(BindooApp.userUID))
              .collection(BindooApp.subCollectionAddress).document(DateTime.now().millisecondsSinceEpoch.toString())
              .setData({
            'receiverName':receiverName.text,
            'receiverPhone':receiverPhone.text,
            'receiverAddress':receiverAddress.text,
          }).then((value) {
           Fluttertoast.showToast(msg: "Address Added Successfully");
           _formKey.currentState.reset();
          });
        }

        }),
  ],
),


                  new SizedBox(
                    height: 10.0,
                  ),


                  new SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  Future<Address>convertCoordinatesToAddress(Coordinates coordinates) async{
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }


}
