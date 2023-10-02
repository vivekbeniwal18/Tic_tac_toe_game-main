

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String player1;
  final String player2;

  const GamePage({super.key, required this.player1, required this.player2});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X ="X";
  static const String PLAYER_Y = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""]; //9 empty places
  }
  void show(String msg){
    AwesomeDialog(context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        btnOkText: "Play Again",
        title:msg,
        btnOkOnPress: (){
          setState(() {
            initializeGame();
          });
        }

    )..show();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            SizedBox(height: 20,),
            _gameContainer(),

          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        const Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.green,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Turn : ",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            Text(currentPlayer=="X"?widget.player1+"($currentPlayer)":widget.player2+"($currentPlayer)",
              style: TextStyle(
                  color:currentPlayer=="X"?
                  Colors.blue:
                  Colors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),),
          ],
        ),
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        //on click of box
        if (gameEnd || occupied[index].isNotEmpty) {
          //Return if game already ended or box already clicked
          return;
        }

        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        color: occupied[index].isEmpty
            ? Colors.black26
            : occupied[index] == PLAYER_X
            ? Colors.blue
            : Colors.orange,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }



  changeTurn() {
    if (currentPlayer == PLAYER_X) {
      currentPlayer = PLAYER_Y;
    } else {
      currentPlayer = PLAYER_X;
    }
  }

  checkForWinner() {
    //Define winning positions
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          //all equal means player won
          show("Player ${playerPosition0=="X"?widget.player1:widget.player2} Won");
          gameEnd = true;
          return;
        }
      }
    }
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        //at least one is empty not all are filled
        draw = false;
      }
    }

    if (draw) {
      show("It's a Tie ");
      gameEnd = true;
    }
  }


}
