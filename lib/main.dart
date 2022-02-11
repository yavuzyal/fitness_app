import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/enter_screen.dart';
import 'package:fitness_app/register1.dart';
import 'package:fitness_app/register3.dart';
import 'package:flutter/material.dart';

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
              child: Text('dsdjafndsajfnsajfşnsdajflnsafjlsandfjldsfnsljdfnsdjlfndsjofldnsafjosdnafdsjolfndwsjofndsojfndsıjofndwsojfndsojfndsjo',
                overflow: TextOverflow.clip, style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
            SizedBox(height: 15,),
            OutlinedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register1()),
                  );
                },
                child: Text('Register1')
            ),
            SizedBox(height: 5,),
            OutlinedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Enter_Screen()),
                  );
                },
                child: Text('Enter Screen')
            ),
            SizedBox(height: 5,),
            OutlinedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register3()),
                  );
                },
                child: Text('Register3')
            ),
            SizedBox(height: 5,),
            OutlinedButton(
                onPressed: (){

                },
                child: Text('Continue Without Login')
            ),
          ],
        ),
      )
    );
  }
}
