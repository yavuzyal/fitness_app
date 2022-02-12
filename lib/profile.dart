import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/service/signInGoogle.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _user = FirebaseAuth.instance.currentUser;
  signInGoogle service = signInGoogle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            service.signOutFromGoogle().then((value) =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                ),
            );
          },
          child: Text('logOut'),
        ),
      ),
    );
  }

}


