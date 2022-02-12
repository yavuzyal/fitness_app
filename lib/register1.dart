import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/profile.dart';
import 'package:fitness_app/register3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Register1 extends StatefulWidget {
  const Register1({Key? key}) : super(key: key);

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {

  late List<bool> isSelected;
  late int currentIndex = 0;
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  late String name;
  late String email;
  late String password;
  late String password_again;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = new TextEditingController();

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
                /*if(currentIndex != index){
                  password = '';
                  email = '';
                }*/
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () async {

                  if(_formKey.currentState!.validate()){
                    if(currentIndex == 1){
                      print('inside sign in part');
                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
                        then((value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register3()),));
                    }
                    else{
                      if(password_again == password){
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async =>
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                          'username': 'get_name',
                          'email': email,
                          'age': -1,
                          'weight': -1,
                          'height': -1,
                          'gender': 'Non-selected',
                        }).then((value) =>
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Profile()),),
                        ),
                        );
                      }
                      else{
                        AlertDialog alert =  AlertDialog(
                          title: Text("Your passwords don't match, please check again!", textAlign: TextAlign.center,),
                          titlePadding: EdgeInsets.all(16),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('OK', style: TextStyle(fontSize: 16),),
                            ),
                          ],
                        );

                        showDialog(context: context, builder: (BuildContext context){
                          return alert;
                        });
                      }
                    }
                  }
                  else{
                    print('There is a problem!');
                  }

                },
                child: Text('Continue')
            ),
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
                  if (value == null || value.isEmpty || value == '') {
                    return 'Please enter some text';
                  }
                  else if(!EmailValidator.validate(value)){
                    return 'Please enter a valid email';
                  }
                  else{
                    email = value;
                    print(email);
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
                  hintText: 'Enter Your Email',
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('Password', style: TextStyle(fontSize: 16),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              child: TextFormField(
                obscureText: !_passwordVisible,
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Please enter some text';
                  }
                  else{
                    password = value;
                    print(password);
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: _passwordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            FlutterPwValidator(
                controller: controller,
                minLength: 6,
                width: 300,
                height: 30,
              onSuccess: () {},
              onFail: () {},
            ),
            //SizedBox(height: 10,),
            Text('Re-write Password', style: TextStyle(fontSize: 16),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              child: TextFormField(
                obscureText: !_passwordVisible1,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Please enter some text';
                  }
                  else{
                    password_again = value;
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Enter Password Again',
                  suffixIcon: IconButton(
                    icon: _passwordVisible1 ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible1 = !_passwordVisible1;
                      });
                    },
                  ),
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
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter some text';
                }
                else{
                  email = value;
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
                hintText: 'Enter Your Email',
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text('Password', style: TextStyle(fontSize: 16),),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            child: TextFormField(
              obscureText: !_passwordVisible2,
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter some text';
                }
                else{
                  password = value;
                }
                return null;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Enter Password',
                suffixIcon: IconButton(
                  icon: _passwordVisible2 ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passwordVisible2 = !_passwordVisible2;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}


