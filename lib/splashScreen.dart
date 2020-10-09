import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/vsComputer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 140.0, left: 24, right: 24),
                child: Container(
                  child: Text(
                    "TIC TAC TOE",
                    style: TextStyle(
                        fontSize: 30, color: Colors.white, letterSpacing: 3),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: AvatarGlow(
                    endRadius: 140,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 1),
                    startDelay: Duration(seconds: 1),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.none,
                          ),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        child: Container(
                          child: Image.asset(
                            'images/tictactoelogo.png',
                            color: Colors.white.withOpacity(0.5),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        radius: 80.0,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  _gameSelectButton('vs Computer', true, context),
                  SizedBox(height: 18),
                  _gameSelectButton('vs Player', false, context),
                  SizedBox(height: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameSelectButton(String name, bool vsComputer, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          vsComputer
              ? MaterialPageRoute(
                  builder: (context) => VsComputer(vsComputer: true))
              : MaterialPageRoute(
                  builder: (context) => VsComputer(vsComputer: false)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text(
            name,
            style: TextStyle(letterSpacing: 3, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
