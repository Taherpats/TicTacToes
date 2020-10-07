import 'package:flutter/material.dart';

class VsPlayer extends StatefulWidget {
  @override
  _VsPlayerState createState() => _VsPlayerState();
}

class _VsPlayerState extends State<VsPlayer> {
  bool xTurn = true;
  int oScore = 0, xScore = 0;
  int filledBoxes = 0;
  List<String> displayValue = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  SizedBox(height: 48),
                  Expanded(
                    child: Center(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Player X',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  xScore.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Player O',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  oScore.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _tapped(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[700])),
                              child: Center(
                                child: Text(
                                  displayValue[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 38),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
//            Container(
//                child: Text("Taher Patrawala",
//                    style: TextStyle(color: Colors.white, fontSize: 18))),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 8, left: 8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(48)),
                height: 50,
                width: 50,
                child: Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          xTurn = true;
          _clearBoard();
          setState(() {});
        },
        child: Icon(Icons.replay, color: Colors.black),
      ),
    );
  }

  void _tapped(int index) {
    if (xTurn && displayValue[index] == '') {
      displayValue[index] = 'X';
      filledBoxes += 1;
    } else if (!xTurn && displayValue[index] == '') {
      displayValue[index] = 'O';
      filledBoxes += 1;
    }
    xTurn = !xTurn;
    _checkWinner();
    setState(() {});
  }

  void _checkWinner() {
    // checks 1st row
    if (displayValue[0] == displayValue[1] &&
        displayValue[0] == displayValue[2] &&
        displayValue[0] != '') {
      _showWinDialog(displayValue[0]);
    }

    // checks 2nd row
    if (displayValue[3] == displayValue[4] &&
        displayValue[3] == displayValue[5] &&
        displayValue[3] != '') {
      _showWinDialog(displayValue[3]);
    }

    // checks 3rd row
    if (displayValue[6] == displayValue[7] &&
        displayValue[6] == displayValue[8] &&
        displayValue[6] != '') {
      _showWinDialog(displayValue[6]);
    }

    // checks 1st column
    if (displayValue[0] == displayValue[3] &&
        displayValue[0] == displayValue[6] &&
        displayValue[0] != '') {
      _showWinDialog(displayValue[0]);
    }

    // checks 2nd column
    if (displayValue[1] == displayValue[4] &&
        displayValue[1] == displayValue[7] &&
        displayValue[1] != '') {
      _showWinDialog(displayValue[1]);
    }

    // checks 3rd column
    if (displayValue[2] == displayValue[5] &&
        displayValue[2] == displayValue[8] &&
        displayValue[2] != '') {
      _showWinDialog(displayValue[2]);
    }

    // checks diagonal
    if (displayValue[6] == displayValue[4] &&
        displayValue[6] == displayValue[2] &&
        displayValue[6] != '') {
      _showWinDialog(displayValue[6]);
    }

    // checks diagonal
    if (displayValue[0] == displayValue[4] &&
        displayValue[0] == displayValue[8] &&
        displayValue[0] != '') {
      _showWinDialog(displayValue[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Draw'),
          actions: [
            FlatButton(
              child: Text(
                "Play Again!",
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    _clearBoard();
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Winner: ' + winner),
          actions: [
            FlatButton(
              child: Text("Play Again!", style: TextStyle(fontSize: 12)),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );

    if (winner == 'X') {
      xScore += 1;
    } else {
      oScore += 1;
    }
  }

  void _clearBoard() {
    for (int i = 0; i < 9; i++) {
      displayValue[i] = '';
    }
    filledBoxes = 0;
    setState(() {});
  }
}
