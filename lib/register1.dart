import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register1 extends StatefulWidget {
  const Register1({Key? key}) : super(key: key);

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {

  late List<bool> isSelected;
  late int currentIndex = 0;
  late String name;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    isSelected = [true, false];
    //currentIndex = 0;
    super.initState();
  }

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
        children: [
          SizedBox(height: 150,),
          ToggleButtons(
            borderColor: Colors.black,
            fillColor: Colors.grey,
            borderWidth: 2,
            selectedBorderColor: Colors.black,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(15),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 35),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 35),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                currentIndex = index;
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
            },
            isSelected: isSelected,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              currentIndex == 0 ?
              signUp() : signIn(),
            ],
          ),
          Spacer(),

          currentIndex == 0 ?
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('dsdjafndsajfnsajfşnsdajflnsafjlsandfjldsfnsljdfnsdjlfndsjofldnsafjosdnafdsjolfndwsjofndsojfndsıjofndwsojfndsojfndsjo',
            overflow: TextOverflow.clip, style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),) : SizedBox(height: 0,),

          currentIndex == 0 ?
          SizedBox(height: 30,) : SizedBox(height: 0,),
          OutlinedButton(

              onPressed: (){

              },
              child: Text('Continue')
          ),
          SizedBox(height: 70,),
        ],
      ),
    );
  }

  Widget signUp(){
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 25,),
            Text('Email', style: TextStyle(fontSize: 16),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
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
            SizedBox(height: 10,),
            Text('Password', style: TextStyle(fontSize: 16),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
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
                  hintText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('Re-write Password', style: TextStyle(fontSize: 16),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
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
                  hintText: 'Enter Password Again',
                ),
              ),
            ),
          ],
        ),
    );
  }


  Widget signIn(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 25,),
          Text('Email', style: TextStyle(fontSize: 16),),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
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
          SizedBox(height: 10,),
          Text('Password', style: TextStyle(fontSize: 16),),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
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
                hintText: 'Enter Password',
              ),
            ),
          ),
        ],
      ),
    );
  }

}


