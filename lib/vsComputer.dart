import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VsComputer extends StatefulWidget {
  @override
  _VsComputerState createState() => _VsComputerState();
}

class _VsComputerState extends State<VsComputer> {
  int oScore = 0, xScore = 0;
  int filledBoxes = 0;
  List<String> displayValue = ['', '', '', '', '', '', '', '', ''];
  String winner = '';
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
          _clearBoard();
          setState(() {});
        },
        child: Icon(Icons.replay, color: Colors.black),
      ),
    );
  }

  int _tapped(int index) {
    if (displayValue[index] == '') {
      displayValue[index] = 'O';
      setState(() {});
      if (!isMovesLeft(displayValue)) {
        _showDrawDialog();
        return 0;
      }
      _bestMove(displayValue);
      if (_checkGame() != '') {
        _showWinDialog(_checkGame());
      }
      setState(() {});
    }
    return 0;
  }

  String _checkGame() {
    for (int i = 0; i < 9; i += 3) {
      if (displayValue[i] != '' &&
          displayValue[i] == displayValue[i + 1] &&
          displayValue[i + 1] == displayValue[i + 2]) {
        winner = displayValue[i];
        return winner;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (displayValue[i] != '' &&
          displayValue[i] == displayValue[i + 3] &&
          displayValue[i + 3] == displayValue[i + 6]) {
        winner = displayValue[i];
        return winner;
      }
    }
    if (displayValue[0] != '' &&
            (displayValue[0] == displayValue[4] &&
                displayValue[4] == displayValue[8]) ||
        (displayValue[2] != '' &&
            displayValue[2] == displayValue[4] &&
            displayValue[4] == displayValue[6])) {
      winner = displayValue[4];
      return winner;
    }
    return '';
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
    _clearBoard();
  }

  void _showWinDialog(String winner) {
    print(winner);
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

  int _eval(List<String> _board) {
    for (int i = 0; i < 9; i += 3) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 1] &&
          _board[i + 1] == _board[i + 2]) {
        winner = _board[i];
        return (winner == 'X') ? 10 : -10;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 3] &&
          _board[i + 3] == _board[i + 6]) {
        winner = _board[i];
        return (winner == 'X') ? 10 : -10;
      }
    }
    if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
        (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
      winner = _board[4];
      return (winner == 'X') ? 10 : -10;
    }
    return 0;
  }

  bool isMovesLeft(List<String> _board) {
    int i;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') return true;
    }
    return false;
  }

  int miniMax(List<String> _board, int depth, bool isMax) {
    int score = _eval(_board);
    int best = 0, i;

    if (score == 10 || score == -10) return score;
    if (!isMovesLeft(_board)) return 0;
    if (isMax) {
      best = -1000;
      for (i = 0; i < 9; i++) {
        if (_board[i] == '') {
          _board[i] = 'X';
          best = max(best, miniMax(_board, depth + 1, false));
          _board[i] = '';
        }
      }
      return best;
    } else {
      best = 1000;
      for (i = 0; i < 9; i++) {
        if (_board[i] == '') {
          _board[i] = 'O';
          best = min(best, miniMax(_board, depth + 1, true));
          _board[i] = '';
        }
      }
      return best;
    }
  }

  int _bestMove(List<String> _board) {
    int bestMove = -1000, moveVal;
    int i, bi;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        moveVal = -1000;
        _board[i] = 'X';
        moveVal = miniMax(_board, 0, false);
        _board[i] = '';
        if (moveVal > bestMove) {
          bestMove = moveVal;
          bi = i;
        }
      }
    }
    _board[bi] = 'X';
    setState(() {});
    return bestMove;
  }
}
