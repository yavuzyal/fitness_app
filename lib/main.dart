import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/enter_screen.dart';
import 'package:fitness_app/profile.dart';
import 'package:fitness_app/register1.dart';
import 'package:fitness_app/register3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'service/signInGoogle.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/fitness_logo.png', width: 150, height: 150,),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("You miss 100% of the shots you don't take. -Wayne Gretzky\n-Michael Scott",
                overflow: TextOverflow.clip, style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  SignInButton(
                    Buttons.Email,
                    elevation: 5,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register1()),
                      );
                    },
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 5,),
                  SizedBox(height: 5,),
                  SignInButton(
                    Buttons.Google,
                    elevation: 5,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      signInGoogle service = signInGoogle();
                      try {
                        service.signInwithGoogle().then((value) =>  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register3()),));

                        //Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
                      } catch(e){
                        if(e is FirebaseAuthException){
                          print(e.message!);
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 5,),
                  SizedBox(height: 5,),
                  SignInButton(
                    Buttons.Facebook,
                    elevation: 5,
                    onPressed: () {
                      AlertDialog alert =  AlertDialog(
                        title: Text('On Progress :(', textAlign: TextAlign.center,),
                        titlePadding: EdgeInsets.all(16),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('OK NO PROBLEM :)', style: TextStyle(fontSize: 16),),
                          ),
                        ],
                      );

                      showDialog(context: context, builder: (BuildContext context){
                        return alert;
                      });
                    },
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 5,),
                  SizedBox(height: 5,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                        minimumSize: Size.fromHeight(40),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signInAnonymously().then((value) async =>
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                          'username': 'get_name',
                          'email': 'anonymous',
                          'age': -1,
                          'weight': -1,
                          'height': -1,
                          'gender': 'Non-selected',
                        }).then((value) =>
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Register3()),),
                        ),
                        );
                      },
                      child: Text('Continue without SignUp', style: TextStyle(fontSize: 15,),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
