import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';

int height = 180;
int wieght = 10;
int age = 10;
int _selectedIndex = 1;

void reset() {
  height = 120;
  age = 0;
  wieght = 0;
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

  // void cch(Gender gendertype) {
  //   if (gendertype == Gender.male) {
  //     (mc == inactivCardColor)
  //         ? {
  //             mc = colourrr,
  //             fc = inactivCardColor,
  //           }
  //         : mc = inactivCardColor;
  //   } else if (gendertype == Gender.female) {
  //     (fc == inactivCardColor)
  //         ? {fc = colourrr, mc = inactivCardColor}
  //         : fc = inactivCardColor;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 40,
          selectedIconTheme: IconThemeData(
            color: const Color(0xFF200087),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home),
              ),
              title: Text(
                "Home",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.calculate),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "BMI Calculator",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.person),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "Profile",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int _selectedIndex) {
            switch (_selectedIndex) {
              case 0:
                Navigator.popAndPushNamed(
                  context,
                  '/profileScreen'
                );
                break;
              // case 1:
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) {
              //       return InputPage();
              //     }),
              //   );
              //   break;
              // case 2:
              //   Navigator.popAndPushNamed(
              //     context,
                  
              //   );
              //   break;
            }
          },
        ),
      ),
      backgroundColor: Color(0xFF0A0E21),
      // appBar: AppBar(
      //   title: Center(
      //     child: Text('BMI CALCULATOR'),
      //   ),
      //   leading: GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           reset();
      //         });
      //       },
      //       child: Icon(Icons.refresh)),
      // ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
          ),
          // Expanded(
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Expanded(
          //         child: ReusableCard(
          //           colorr: mc,
          //           cardChild: ReusableCol(
          //             icona: FontAwesomeIcons.mars,
          //             texta: 'Male',
          //           ),
          //           onPress: () {
          //             setState(() {
          //               cch(Gender.male);
          //             });
          //           },
          //         ),
          //       ),
          //       Expanded(
          //         child: ReusableCard(
          //           colorr: fc,
          //           onPress: () {
          //             setState(() {
          //               cch(Gender.female);
          //             });
          //           },
          //           cardChild: ReusableCol(
          //             icona: FontAwesomeIcons.venus,
          //             texta: 'Female',
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0XFF8D8E98)),
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
                                    fontSize: 18.0, color: Color(0XFF8D8E98)))
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
                              color: Color(0XFF8D8E98),
                            )),
                        Text(
                          wieght.toString(),
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
                                    wieght--;
                                  });
                                },
                              ),
                              Button(
                                iconvalue: FontAwesomeIcons.plus,
                                f: () {
                                  setState(() {
                                    wieght++;
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
                              color: Color(0XFF8D8E98),
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
                                    age--;
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
                  new Calculate_bmi(height: height, weight: wieght);
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
                  'CALCULATE BI',
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
      child: Icon(iconvalue),
      onPressed: f,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      elevation: 6.0,
      fillColor: Color(0XFF4C4F5E),
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
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text('  Your Results are',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w900)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Color(0xFF1D1F33)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    bmi2,
                    style: TextStyle(color: Colors.green, fontSize: 17.0),
                  ),
                  Text(
                    bmi1,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50.0,
                    ),
                  ),
                  Text(bmi3, style: TextStyle(letterSpacing: 1.0))
                ],
              ),
            ),
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
    );
  }
}
