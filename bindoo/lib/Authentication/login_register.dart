import 'dart:async';
import 'dart:io';
import 'package:bindoo/start_up.dart';
import 'package:path/path.dart' as Path;
import 'package:bindoo/Config/config.dart';
import 'package:bindoo/DialogBox/error_dialog.dart';
import 'package:bindoo/DialogBox/loadingDialog.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}
enum FormType { login, register }
class _LoginRegisterState extends State<LoginRegister> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  String _name = "";
  String userImage = "";
  File _imageFile ;
  final picker = ImagePicker();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _cPasswordController = new TextEditingController();

  void moveToRegister() {
    _formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }
  void moveToLogin() {
    _formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: Colors.transparent,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: new SizedBox(
                      height: 150.0,
                      width: double.infinity,
                      child:  Carousel(
                        images: [
                          AssetImage('images/slide2.jpg'),
                          AssetImage('images/slide1.jpg'),
                        ],
                        dotBgColor: Colors.transparent,
                        dotColor: Theme.of(context).primaryColor,
                        overlayShadow: true,
                        overlayShadowColors: Colors.white,
                        overlayShadowSize: 0.9,
                        dotSize: 4,
                      )),
                ),

              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40,),

                  Card(
                    elevation: 8,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Form(
                          key: _formKey,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: createImput() + createButtons(),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),),
    );
  }
  List<Widget> createImput() {
    if (_formType == FormType.login) {
      return [

        new Text("Login",style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
        new TextFormField(
          controller: _emailController,
          decoration: new InputDecoration(
            labelText: 'Email',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.mail_outline,
              color: const Color(0xFF00C9C9),
            ),
          ),
          validator: (value) {
            return value.isEmpty ? 'Email is required' : null;
          },
          onSaved: (value) {
            return _email = value;
          },
        ),
        SizedBox(
          height: 10,
        ),
        new TextFormField(
          controller: _passwordController,
          decoration: new InputDecoration(
            labelText: 'Password',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.lock_open,
              color: const Color(0xFF00C9C9),
            ),
            suffixIcon:  IconButton(
              onPressed: _toggle,
              icon: Icon(Icons.visibility_off),

            ),
          ),
          obscureText: _obscureText,
          validator: (value) {
            return value.length<6 ? 'Password too short' : null;
          },
          onSaved: (value) {
            return _password = value;
          },
        ),

        SizedBox(
          height: 30,
        ),
      ];
    } else if (_formType == FormType.register) {
      return [
        new Text("Register",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        SizedBox(
          height: 20,
        ),
InkWell(
  onTap: _selectAndPickImage,
  child: CircleAvatar(
    radius: 40,
    backgroundImage: _imageFile==null? null : FileImage(_imageFile),
    child: _imageFile==null? Image(image: AssetImage('images/userPik.png',),height: 35,)
        :null
  ),
),
        new TextFormField(
          controller: _nameController,
          decoration: new InputDecoration(
            labelText: 'Name',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.person_outline,
              color: const Color(0xFF00C9C9),
            ),
          ),
          validator: (value) {
            return value.isEmpty ? 'Name is required' : null;
          },
          onSaved: (value) {
            return _name = value;
          },
        ),
        SizedBox(
          height: 10,
        ),
        new TextFormField(
          controller: _emailController,
          decoration: new InputDecoration(
            labelText: 'Email',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.mail_outline,
              color: const Color(0xFF00C9C9),
            ),
          ),
          validator: (value) {
            return value.isEmpty ? 'Email is required' : null;
          },
          onSaved: (value) {
            return _email = value;
          },
        ),
        SizedBox(
          height: 10,
        ),
        new TextFormField(
          controller: _passwordController,
          decoration: new InputDecoration(
            labelText: 'Password',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.lock_open,
              color: const Color(0xFF00C9C9),
            ),
            suffixIcon:  IconButton(
              onPressed: _toggle,
              icon: Icon(Icons.visibility_off),

            ),

          ),
          obscureText: _obscureText,
          validator: (value) {
            return value.length<6 ? 'Password too short' : null;
          },
          onSaved: (value) {
            return _password = value;
          },
        ),
        new TextFormField(
          controller: _cPasswordController,
          decoration: new InputDecoration(
            labelText: 'Confirm Password',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.lock_open,
              color: const Color(0xFF00C9C9),
            ),
            suffixIcon:  IconButton(
              onPressed: _toggle,
              icon: Icon(Icons.visibility_off),

            ),

          ),
          obscureText: _obscureText,
          validator: (value) {
            return value.length<6 ? 'Password too short' : null;
          },
          onSaved: (value) {
            return _password = value;
          },
        ),
        SizedBox(
          height: 30,
        ),
      ];
    }
  }
  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        new Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            onPressed: _loginUser,
            color: Theme.of(context).primaryColor,
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway',
                fontSize: 17,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("No account Yet?",style: TextStyle(color: Colors.grey)),
            new FlatButton(
              onPressed: moveToRegister,
              child: Text(
                "Register",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ];
    } else {
      return [
        new Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 40,
          
          child: FlatButton(
            shape: new RoundedRectangleBorder(

              borderRadius: new BorderRadius.circular(30.0),
            ),
            onPressed: (){uploadAndSaveImage();},
            color: Theme.of(context).primaryColor,
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway',
                fontSize: 17,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Already have Account?",style: TextStyle(color: Colors.grey)),
            new FlatButton(
              onPressed: moveToLogin,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),

      ];
    }
  }
  //methods
  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: Opacity(
                opacity: 1.0,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );
          },
        );
        new Future.delayed(new Duration(seconds: 3), () async {


        });
      } catch (e) {

        print("Error: " + e.toString());
      }
    }

  }
  Future<void>_selectAndPickImage() async{
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  }

  Future<void>uploadAndSaveImage() async{
    if(_imageFile==null){
      showDialog(
          context: context,
      builder: (c){
            return ErrorAlertDialog(message: 'Please select Image',);
      }
      );
    }
    else{_passwordController.text==_cPasswordController.text?
        _emailController.text.isNotEmpty&&_nameController.text.isNotEmpty&&
    _passwordController.text.isNotEmpty
      ? uploadToStorage()
            :displayDialog('Please Fill All Fields')
        :displayDialog('Passwords do not match');
    }
  }
displayDialog(String msg){
    showDialog(context: context,
    builder: (c){
      return ErrorAlertDialog(message: msg,);
    });
}
uploadToStorage()async{
  showDialog(context: context,
      builder: (c){
        return LoadingAlertDialog(message: 'Authenticating, Please wait......',);
      });
  String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
  StorageReference storageReference = FirebaseStorage.instance.ref().child(imageFileName);
  StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
  StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
  await taskSnapshot.ref.getDownloadURL().then((urlImage){
    userImage = urlImage;
_registerUser();
  });
}
FirebaseAuth _auth = FirebaseAuth.instance;
void _registerUser() async{

  FirebaseUser firebaseUser;
  await _auth.createUserWithEmailAndPassword(email: _emailController.text.trim(),
      password: _passwordController.text.trim()).then((auth) {
        firebaseUser = auth.user;

  }).catchError((error){
    Navigator.pop(context);
    showDialog(context: context,
        builder: (c){
          return ErrorAlertDialog(message: error.message.toString(),);
        });
  });
  if(firebaseUser!=null){
    saveUserInfo(firebaseUser).then((value){
      Navigator.of(context, rootNavigator: true).pop();



    });
    Timer(
        Duration(seconds: 2),
            () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginRegister())));
  }
}
  void _loginUser() async{
    showDialog(context: context,
        builder: (c){
          return LoadingAlertDialog(message: 'Authenticating, Please wait......',);
        });
    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim()).then((auth) {
      firebaseUser = auth.user;

    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context,
          builder: (c){
            return ErrorAlertDialog(message: error.message.toString(),);
          });
    });
    if(firebaseUser!=null){
       readData(firebaseUser);
      Timer(
          Duration(seconds: 2),
              () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StartUpPage())));
    }
  }
Future saveUserInfo(FirebaseUser fUser) async{
  Firestore.instance.collection('users').document(fUser.uid).setData({
  'uid':fUser.uid,
    'email':fUser.email,
    'name':_nameController.text.trim(),
    'url':userImage,
    BindooApp.userCartList:['garbageValue'],
    BindooApp.userOrderList:['noOrderValue']
  });
  await BindooApp.sharedPreferences.setString('uid', fUser.uid);
  await BindooApp.sharedPreferences.setString(BindooApp.userEmail, fUser.email);
  await BindooApp.sharedPreferences.setString(BindooApp.userName, _nameController.text);
  await BindooApp.sharedPreferences.setString(BindooApp.userAvatarUrl, userImage);
  await BindooApp.sharedPreferences.setStringList(BindooApp.userCartList, ['garbageValue']);
  await BindooApp.sharedPreferences.setStringList(BindooApp.userOrderList, ['noOrderValue']);

}

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageFile = image;
      });
    });
  }
  Future readData(FirebaseUser fUser) async{
    Firestore.instance.collection('users').document(fUser.uid).get().then((dataSnapshot)async{
      await BindooApp.sharedPreferences.setString('uid', dataSnapshot.data[BindooApp.userUID]);
      await BindooApp.sharedPreferences.setString(BindooApp.userEmail, dataSnapshot.data[BindooApp.userEmail]);
      await BindooApp.sharedPreferences.setString(BindooApp.userName, dataSnapshot.data[BindooApp.userName]);
      await BindooApp.sharedPreferences.setString(BindooApp.userAvatarUrl, dataSnapshot.data[BindooApp.userAvatarUrl]);
      List<String> cartList = dataSnapshot.data[BindooApp.userCartList].cast<String>();
      await BindooApp.sharedPreferences.setStringList(BindooApp.userCartList, cartList);
      List<String> orderList = dataSnapshot.data[BindooApp.userOrderList].cast<String>();
      await BindooApp.sharedPreferences.setStringList(BindooApp.userOrderList, orderList);
    });
  }
}
