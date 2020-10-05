import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool XTurn = true; // player x
  int OScore = 0, XScore = 0;
  int filledBoxes = 0;
  List<String> displayValue = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
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
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 12),
                        Text(
                          XScore.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 12),
                        Text(
                          OScore.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                          style: TextStyle(color: Colors.white, fontSize: 38),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    if (XTurn && displayValue[index] == '') {
      displayValue[index] = 'X';
      filledBoxes += 1;
    } else if (!XTurn && displayValue[index] == '') {
      displayValue[index] = 'O';
      filledBoxes += 1;
    }
    XTurn = !XTurn;
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
              child: Text("Play Again!"),
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
              child: Text("Play Again!"),
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
      XScore += 1;
    } else {
      OScore += 1;
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
