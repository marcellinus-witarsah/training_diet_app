import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/ui/bottom_nav_bar.dart';

int height = 180;
int weight = 10;
int age = 10;

void reset() {
  height = 120;
  age = 0;
  weight = 0;
}

enum Gender { male, female }

const bottomContainerHeight = 80.0;
const colourrr = Color(0xFF1D1F33);
const inactivCardColor = Color(0xFF111328);

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color mc = inactivCardColor;
  Color fc = inactivCardColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavBar(1),
      ),
      backgroundColor: Colors.white,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomLeft,
      //         colors: [Color(0xFF20008B), Colors.black]),
      //   ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colorr: colourrr,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                        ),
                        Text(
                          'HEIGHT',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(height.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50.0,
                                  color: Colors.white,
                                )),
                            Text('CM',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white))
                          ],
                        ),
                        Flexible(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.pink,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0),
                              activeTrackColor: Colors.white,
                              overlayColor: Colors.pink[200],
                            ),
                            child: Slider(
                              value: height.toDouble(),
                              min: 120.0,
                              max: 220.0,
                              inactiveColor: Colors.grey,
                              onChanged: (double newValue) {
                                setState(() {
                                  height = newValue.round();
                                  print(height);
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colorr: colourrr,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('WEIGHT',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                        Text(
                          weight.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Button(
                                iconvalue: FontAwesomeIcons.minus,
                                f: () {
                                  setState(() {
                                    if (weight > 0) {
                                      weight--;
                                    }
                                  });
                                },
                              ),
                              Button(
                                iconvalue: FontAwesomeIcons.plus,
                                f: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colorr: colourrr,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('AGE',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                        Text(
                          age.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Button(
                                iconvalue: FontAwesomeIcons.minus,
                                f: () {
                                  setState(() {
                                    if (age > 0) {
                                      age--;
                                    }
                                  });
                                },
                              ),
                              Button(
                                iconvalue: FontAwesomeIcons.plus,
                                f: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Calculate_bmi calc =
                  new Calculate_bmi(height: height, weight: weight);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                            bmi1: calc.bmi_calculator(),
                            bmi2: calc.result1(),
                            bmi3: calc.result2(),
                          )));
            },
            child: Container(
              child: Center(
                child: Text(
                  'CALCULATE BMI',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: bottomContainerHeight,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  @override
  Function f;
  IconData iconvalue;
  Button({@required this.iconvalue, @required this.f});
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        iconvalue,
        color: Colors.white,
      ),
      onPressed: f,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      elevation: 6.0,
      fillColor: Color(0xFF5B4D9D),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colorr, this.cardChild, this.onPress});
  final Color colorr;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: cardChild,
        decoration: BoxDecoration(
          color: colorr,
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF20008B),
              const Color(0xFF200087),
            ],
          ),
        ),
        height: 200,
        width: 170,
      ),
    );
  }
}

class ReusableCol extends StatelessWidget {
  ReusableCol({this.icona, this.texta});
  final IconData icona;
  final String texta;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icona,
          size: 80.0,
          color: Colors.white,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          texta,
          style: TextStyle(fontSize: 18.0, color: Color(0XFF8D8E98)),
          // style: TextStyle(
          //     fontSize: 18.0,
          //     fontStyle: FontStyle.italic
          // ),
        )
      ],
    );
  }
}

class Calculate_bmi {
  Calculate_bmi({@required this.weight, @required this.height});

  int height;
  int weight;
  double _bmi;

  String bmi_calculator() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String result1() {
    if (_bmi >= 25)
      return 'OVERWEIGHT';
    else if (_bmi > 18.5)
      return 'NORMAL WEIGHT';
    else
      return 'UNDERWEIGHT';
  }

  String result2() {
    if (_bmi >= 25)
      return 'YOU HAVE OVERWEIGHT BODY NEED HEAVY EXCERCISE';
    else if (_bmi > 18.5)
      return 'YOU HAVE NORMAL BODY NEED LEAST EXCERCISE';
    else
      return 'YOU HAVE UNDERWEIGHED BODY NEED TO EAT A BIT MORE';
  }
}

InputPage ip = new InputPage();

class ResultPage extends StatelessWidget {
  @override
  ResultPage({@required this.bmi1, @required this.bmi2, @required this.bmi3});

  final String bmi1;
  final String bmi2;
  final String bmi3;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(1),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF20008B),
                        const Color(0xFF200087),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '  Your Results are',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        bmi2,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        bmi1,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 50.0,
                            color: Colors.white),
                      ),
                      Text(
                        bmi3,
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                reset();
                Navigator.pop(context);
              },
              child: Container(
                child: Center(
                  child: Text(
                    'RE-CALCULATE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 80.0,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
