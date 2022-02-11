import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register3 extends StatefulWidget {
  const Register3({Key? key}) : super(key: key);

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {

  final _formKey = GlobalKey<FormState>();
  late String name;

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
          Text('Name', style: TextStyle(fontSize: 25),),
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
          OutlinedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  //print('oldu');
                }
              },
              child: Text('Continue', style: TextStyle(fontSize: 15,),)),
        ],
      ),
    );
  }
}
