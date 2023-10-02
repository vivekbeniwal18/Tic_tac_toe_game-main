import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen.dart';

import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _fromkey=  GlobalKey<FormState>();
  final TextEditingController player1=TextEditingController();
  final TextEditingController player2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: Form(
        key: _fromkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Player Name",style:TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30
            ),),
            SizedBox(height: 30,),
            Padding(
                padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: player1,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  hintText: "Player 1 Name ",
                  hintStyle: TextStyle(color: Colors.white)
                ),
                validator: (value){
                  if(value==null || value.isEmpty)
                    {
                      return "Please enter player 1 name ";
                    }
                  return null;
                },
              ),


            ),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: player2,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    hintText: "Player 2 Name ",
                    hintStyle: TextStyle(color: Colors.white)
                ),
                validator: (value){
                  if(value==null || value.isEmpty)
                  {
                    return "Please enter player 2 name ";
                  }
                  return null;
                },
              ),


            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Background color
                ),
                  onPressed: (){
                  if(_fromkey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GamePage(player1: player1.text, player2: player2.text)));
                  }
                  },
                  child: Text("Start Game",style: TextStyle(fontSize: 24),),
              ),
            )
          ],
        ),
      ),

    );
  }
}
