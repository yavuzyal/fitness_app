import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:numberpicker/numberpicker.dart';

class Enter_Screen extends StatefulWidget {
  const Enter_Screen({Key? key}) : super(key: key);

  @override
  State<Enter_Screen> createState() => _Enter_ScreenState();
}

class _Enter_ScreenState extends State<Enter_Screen> {

  int _currentPosition = 0;
  int _currentValueAge = 25;
  int _currentValueHeight = 150;
  int _currentValueWeight = 50;
  String sex = 'Non-selected';

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
          _currentPosition == 0 ? Column(
            children: [
              Text('Gender', style: TextStyle(fontSize: 25),),
            ],
          ) :
          _currentPosition == 1 ? Column(
            children: [
              Text('Age', style: TextStyle(fontSize: 25),),
            ],
          ) :
          _currentPosition == 2 ? Column(
            children: [
              Text('Height (cm)', style: TextStyle(fontSize: 25),),
            ],
          ) :
          _currentPosition == 3 ? Column(
            children: [
              Text('Weight (kg)', style: TextStyle(fontSize: 25),),
            ],
          ) : SizedBox(),
          Spacer(),
          _currentPosition == 0 ? gender() :
          _currentPosition == 1 ? age() :
          _currentPosition == 2 ? height() :
          _currentPosition == 3 ? weight() : SizedBox(),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: (){
                if(_currentPosition == 3){

                }
                else{
                  if(_currentPosition == 0 && sex == 'Non-selected'){
                    AlertDialog alert =  AlertDialog(
                      title: Text('For optimal suggestions, please select your gender!', textAlign: TextAlign.center,),
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
                  else{
                    //GENDER FIREBASE EKLE
                    setState(() {
                      _currentPosition = _currentPosition + 1;
                    });
                  }
                }
              },
              child: _currentPosition != 3 ? Text('Next' ,style: TextStyle(color: Colors.white),):Text('Save')),
          ),
          SizedBox(height: 30,),
          Center(
            child: DotsIndicator(
              position: _currentPosition.toDouble(),
                dotsCount: 4
            ),
          ),
          SizedBox(height: 70,),
        ],
      ),
      );
  }

  Widget gender(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            sex == 'Non-selected' || sex == 'Male' ?
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    sex = 'Female';
                  });
                },
                child: Icon(Icons.female, size: 120, color: Colors.grey[300],),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.all(15),
                  primary: Colors.grey[50],
                  shadowColor: Colors.grey[100],
                  elevation: 10,
                )
            ) :
            ElevatedButton(
                onPressed: () {

                },
                child: Icon(Icons.female, size: 120, color: Colors.redAccent,),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.all(15),
                  primary: Colors.grey[50],
                  shadowColor: Colors.grey[100],
                  elevation: 15,
                )
            ),
            SizedBox(height: 15,),
            Text('Woman', style: TextStyle(fontSize: 17),),
          ],
        ),

        SizedBox(width: 25,),

        Column(
          children: [
            sex == 'Non-selected' || sex == 'Female' ?
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    sex = 'Male';
                  });
                },
                child: Icon(Icons.male, size: 120, color: Colors.grey[300],),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.all(15),
                  primary: Colors.grey[50],
                  shadowColor: Colors.grey[100],
                  elevation: 10,
                )
            ) :
            ElevatedButton(
                onPressed: () {

                },
                child: Icon(Icons.male, size: 120, color: Colors.blue[900],),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.all(15),
                  primary: Colors.grey[50],
                  shadowColor: Colors.grey[100],
                  elevation: 15,
                )
            ),
            SizedBox(height: 15,),
            Text('Man', style: TextStyle(fontSize: 17),),
          ],
        ),
      ],
    );
  }

  Widget age(){
    return NumberPicker(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)
        ),
      ),
      textStyle: TextStyle(fontSize: 17, color: Colors.grey),
      selectedTextStyle: TextStyle(fontSize: 40, color: Colors.black),
      haptics: true,
      itemCount: 5,
      value: _currentValueAge,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => setState(() => _currentValueAge = value),
    );
  }

  Widget height(){
    return NumberPicker(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)
        ),
      ),
      textStyle: TextStyle(fontSize: 17, color: Colors.grey),
      selectedTextStyle: TextStyle(fontSize: 40, color: Colors.black),
      haptics: true,
      itemCount: 5,
      value: _currentValueHeight,
      minValue: 50,
      maxValue: 250,
      onChanged: (value) => setState(() => _currentValueHeight = value),
    );
  }

  Widget weight(){
    return NumberPicker(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)
        ),
      ),
      textStyle: TextStyle(fontSize: 17, color: Colors.grey),
      selectedTextStyle: TextStyle(fontSize: 40, color: Colors.black),
      haptics: true,
      itemCount: 5,
      value: _currentValueWeight,
      minValue: 25,
      maxValue: 350,
      onChanged: (value) => setState(() => _currentValueWeight = value),
    );
  }

}
