import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  final String onumber, xnumber;
  const HomePage({Key? key, required this.onumber, required this.xnumber})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true; // pierwszy gracz to o.
  List<String> display = ['', '', '', '', '', '', '', '', ''];
  int oscore = 0;
  int xscore = 0;

  int filledboxes = 0;

  static var fontwhite = GoogleFonts.orbitron(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Column(
          children: <Widget>[
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Player X', style: fontwhite),
                      Text(xscore.toString(), style: fontwhite)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Player O', style: fontwhite),
                      Text(oscore.toString(), style: fontwhite)
                    ],
                  ),
                ),
              ],
            )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60)),
                        child: Center(
                          child: Text(display[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 40)),
                        )),
                  );
                },
              ),
            ),
            Expanded(
                child: Center(
                    child: Column(
              children: <Widget>[
                Text(
                  "TIC TAC TOE",
                  style: fontwhite,
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'MADE BY SZYMON42571',
                  style: fontwhite,
                ),
                Text(
                  'onumber: ${widget.onumber}',
                  style: fontwhite,
                ),
              ],
            ))),
          ],
        ));
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && display[index] == '') {
        display[index] = "o";
        filledboxes += 1;
      } else if (!oTurn && display[index] == '') {
        display[index] = "x";
        filledboxes += 1;
      }

      oTurn = !oTurn;
      _checkwinner();
    });
  }

  void _checkwinner() {
    // 1 rzad
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      _showWinDialog(display[0]);
      return;
    }

    // 2 rzad
    if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      _showWinDialog(display[3]);
      return;
    }
    // 3 rzad
    if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      _showWinDialog(display[6]);
      return;
    }
    // 1 kolumna
    if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      _showWinDialog(display[0]);
      return;
    }
    // 2 kolumna
    if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      _showWinDialog(display[1]);
      return;
    }
    // 3 kolumna
    if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      _showWinDialog(display[2]);
      return;
    }
    // skos od dolu
    if (display[6] == display[4] &&
        display[6] == display[2] &&
        display[6] != '') {
      _showWinDialog(display[6]);
      return;
    }
    // skos od gory
    if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      _showWinDialog(display[0]);
      return;
    }
    // remis
    if (filledboxes == 9) {
      _showDrawDialog();
      _odrawgame();
      _xdrawgame();
      return;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("DRAW"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                    filledboxes == 0;
                  },
                  child: const Text("Play Again"))
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("$winner wins!"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                    filledboxes == 0;
                  },
                  child: const Text("Play Again"))
            ],
          );
        });

    if (winner == 'o') {
      oscore = oscore + 1;
    } else if (winner == 'x') {
      xscore = xscore + 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        display[i] = '';
        filledboxes == 0;
      }
    });
  }

  void _odrawgame() {
    setState(() {
      if (widget.onumber == '2') {
        while (filledboxes == 9) {
          _showWinDialog;
        }
      }
    });
  }

  void _xdrawgame() {
    setState(() {
      if (widget.xnumber == '2') {
        while (filledboxes == 9) {
          _showWinDialog;
        }
      }
    });
  }
}

class Picker extends StatelessWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.green,
      ),
      home: const Pick(),
    );
  }
}

class Pick extends StatefulWidget {
  const Pick({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PickState createState() => _PickState();
}

class _PickState extends State<Pick> {
  static var myNewFont = GoogleFonts.orbitron(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.orbitron(
      textStyle: const TextStyle(color: Colors.white, letterSpacing: 3));

  var onumber = 0;
  var xnumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      '1-2: Play to win!',
                      style: myNewFontWhite,
                    ),
                    Text(
                      '3-4: Play to draw!',
                      style: myNewFontWhite,
                    ),
                    Text(
                      '5-6: Play to lose!',
                      style: myNewFontWhite,
                    ),
                    Text(
                      '',
                      style: myNewFont,
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                onumber = Random().nextInt(7);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("Your win condition is $onumber"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ),
                );
              },
              child: Text(
                'Generate O Win Condition',
                style: myNewFontWhite,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                xnumber = Random().nextInt(7);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("Your win condition is $onumber"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ),
                );
              },
              child: Text(
                'Generate X Win Condition',
                style: myNewFontWhite,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(
                          onumber: onumber.toString(),
                          xnumber: xnumber.toString(),
                        )));
              },
              child: Text(
                'Let`s play!',
                style: myNewFontWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
