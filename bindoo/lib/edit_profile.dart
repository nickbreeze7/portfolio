
import 'package:flutter/material.dart';

import 'Config/CustomShapeClipper.dart';



class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController receiverName = new TextEditingController();
  TextEditingController receiverPhone = new TextEditingController();
  TextEditingController receiverAddress = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Edit Profile",style: TextStyle(color: Colors.white),),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
          ClipPath(
          clipper: CustomShapeClipper(),
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage('https://goop.com/wp-content/uploads/2020/06/Mask-Group-2.png'),
                              fit: BoxFit.cover)
                      ),
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),

    ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
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
                          hintText: "Digital Address",
                          labelText: 'Digital Address',
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("UPDATE PROFILE"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Theme.of(context).primaryColor)),
                    textColor: Colors.white,
                    onPressed: (){

                    })
              ]
          ),
        ),
      )
    );
  }
}
