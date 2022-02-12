import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/enter_screen.dart';
import 'package:flutter/material.dart';

class Register3 extends StatefulWidget {
  const Register3({Key? key}) : super(key: key);

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {

  final _formKey = GlobalKey<FormState>();
  late String name;
  final _user = FirebaseAuth.instance.currentUser;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 150,),
          Text('Name', style: TextStyle(fontSize: 25),),
          Spacer(),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  else{
                    name = value;
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update(
                        {
                          'name': name,
                        }).then((value) =>
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Enter_Screen()),),
                    );
                  }
                },
                child: Text('Continue', style: TextStyle(fontSize: 15,),
                )
            ),
          ),
          SizedBox(height: 70,),
        ],
      ),
    );
  }
}
