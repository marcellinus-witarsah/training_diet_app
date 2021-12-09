// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_and_diet_app/model/meal.dart';
import 'package:training_and_diet_app/services/auth.dart';
import 'package:training_and_diet_app/services/db.dart';
import 'package:training_and_diet_app/ui/bottom_nav_bar.dart';
import 'package:training_and_diet_app/ui/pages/meal_detail_screen.dart';
import 'package:training_and_diet_app/ui/pages/workout_screen.dart';
import 'package:training_and_diet_app/ui/pages/bmiscreen.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:animations/animations.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // int calculate

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final _db = DatabaseService();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();
    // protein consumed
    double proteinNeeded(calories) {
      return 0.4 * calories / 4.1;
    }

    double carbNeeded(calories) {
      return 0.4 * calories / 4.1;
    }

    double fatNeeded(calories) {
      return 0.2 * calories / 8.8;
    }

    double calorieConsumed(carb, protein, fat) {
      return carb * 4.1 + protein * 4.1 + fat * 8.8;
    }

    Map<String, int> calculateAll(snapshots, calories) {
      double carbLeft = carbNeeded(calories);
      double fatLeft = fatNeeded(calories);
      double proteinLeft = proteinNeeded(calories);
      double carbConsumed = 0;
      double fatConsumed = 0;
      double proteinConsumed = 0;
      double caloriesLeft;
      for (int i = 0; i < snapshots.length; i++) {
        carbConsumed += snapshots[i]["carb"];
        proteinConsumed += snapshots[i]["protein"];
        fatConsumed += snapshots[i]["fat"];
      }

      caloriesLeft = calories -
          calorieConsumed(carbConsumed, proteinConsumed, fatConsumed);
      carbLeft -= carbConsumed;
      proteinLeft -= proteinConsumed;
      fatLeft -= fatConsumed;
      return {
        "calories_left": caloriesLeft.ceilToDouble().toInt(),
        "carb_left": carbLeft.ceilToDouble().toInt(),
        "protein_left": proteinLeft.ceilToDouble().toInt(),
        "fat_left": fatLeft.ceilToDouble().toInt(),
      };
    }

    return StreamBuilder(
      stream: _auth.user,
      builder: (context, snapshot) {
        // print("${snapshot.data}");
        return FutureBuilder<DocumentSnapshot>(
            future: _db.getUserData(snapshot.data.uid),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> docSnapshot) {
              if (docSnapshot.hasData) {
                print(docSnapshot.data['calories']);
                // return Text("${docSnapshot.data['first_name']}");
                return StreamBuilder<QuerySnapshot>(
                    stream: _db.getUserRecordsByID(snapshot.data.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.hasData) {
                        final data = calculateAll(querySnapshot.data.docs,
                            docSnapshot.data['calories']);
                        return Scaffold(
                          backgroundColor: const Color(0xFFE9E9E9),
                          bottomNavigationBar: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(40)),
                            child: BottomNavBar(0),
                          ),
                          body: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                height: height * 0.35,
                                left: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: const Radius.circular(40),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(
                                        top: 40,
                                        left: 16,
                                        right: 16,
                                        bottom: 10),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(
                                            "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Hello, ${docSnapshot.data['first_name']} ${docSnapshot.data['last_name']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 26,
                                              color: Colors.black,
                                            ),
                                          ),
                                          trailing: ClipOval(
                                              child: Image.asset(
                                                  "assets/user.jpg")),
                                        ),
                                        // ],
                                        // ),
                                        //test@test.testtest
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 40,
                                            ),
                                            _RadialProgress(
                                              width: width * 0.2,
                                              height: width * 0.2,
                                              progress: 1 -
                                                  data['calories_left'] /
                                                      docSnapshot
                                                          .data['calories'],
                                              caloriesLeft:
                                                  data['calories_left'],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                _IngredientProgress(
                                                  ingredient: "Protein",
                                                  progress: 1 -
                                                      data['protein_left'] /
                                                          proteinNeeded(
                                                              docSnapshot.data[
                                                                  'calories']),
                                                  progressColor: Colors.green,
                                                  leftAmount:
                                                      data['protein_left'],
                                                  width: width * 0.28,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                _IngredientProgress(
                                                  ingredient: "Carbs",
                                                  progress: 1 -
                                                      data['carb_left'] /
                                                          carbNeeded(
                                                              docSnapshot.data[
                                                                  'calories']),
                                                  progressColor: Colors.red,
                                                  leftAmount: data['carb_left'],
                                                  width: width * 0.28,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                _IngredientProgress(
                                                  ingredient: "Fat",
                                                  progress: 1 -
                                                      data['fat_left'] /
                                                          fatNeeded(
                                                              docSnapshot.data[
                                                                  'calories']),
                                                  progressColor: Colors.yellow,
                                                  leftAmount: data['fat_left'],
                                                  width: width * 0.28,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: height * 0.38,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: height * 0.50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                          left: 32,
                                          right: 16,
                                        ),
                                        child: Text(
                                          "MEALS FOR TODAY",
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 32,
                                              ),
                                              for (int i = 0;
                                                  i < meals.length;
                                                  i++)
                                                _MealCard(
                                                  meal: meals[i],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: OpenContainer(
                                          closedElevation: 0,
                                          // transitionType: ContainerTransitionType.fade,
                                          transitionDuration: const Duration(
                                              milliseconds: 1000),
                                          closedColor: const Color(0xFFE9E9E9),
                                          openBuilder: (context, _) {
                                            return WorkoutScreen();
                                          },
                                          closedBuilder: (context,
                                              VoidCallback openContainer) {
                                            return GestureDetector(
                                              onTap: openContainer,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 32,
                                                    right: 32),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0,
                                                              left: 16),
                                                      child: Text(
                                                        "YOUR NEXT WORKOUT",
                                                        style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0,
                                                              left: 16),
                                                      child: Text(
                                                        "Upper Body",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 50,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                              color: const Color(
                                                                  0xFF5B4D9D),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Image.asset(
                                                              "assets/chest.png",
                                                              width: 50,
                                                              height: 50,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                              color: const Color(
                                                                  0xFF5B4D9D),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Image.asset(
                                                              "assets/back.png",
                                                              width: 50,
                                                              height: 50,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                              color: const Color(
                                                                  0xFF5B4D9D),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Image.asset(
                                                              "assets/biceps.png",
                                                              width: 50,
                                                              height: 50,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Scaffold(
                          body: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                CircularProgressIndicator()
                              ])),
                        );
                      }
                    });
              } else {
                return Scaffold(
                  body: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()])),
                );
              }
            });
      },
    );
  }
}

class _IngredientProgress extends StatefulWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {Key key,
      this.ingredient,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width})
      : super(key: key);

  @override
  State<_IngredientProgress> createState() => _IngredientProgressState();
}

class _IngredientProgressState extends State<_IngredientProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: widget.width * widget.progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: widget.progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text("${widget.leftAmount}g left"),
          ],
        ),
      ],
    );
  }
}

class _RadialProgress extends StatefulWidget {
  final double height, width, progress;
  final int caloriesLeft;

  const _RadialProgress(
      {Key key, this.height, this.width, this.progress, this.caloriesLeft})
      : super(key: key);

  @override
  State<_RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<_RadialProgress> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: widget.progress,
      ),
      child: Container(
        height: widget.height,
        width: widget.width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.caloriesLeft.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF200087),
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "cal left",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF200087),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MealCard extends StatefulWidget {
  final Meal meal;

  const _MealCard({Key key, @required this.meal}) : super(key: key);

  @override
  State<_MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<_MealCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: OpenContainer(
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                transitionDuration: const Duration(milliseconds: 1000),
                openBuilder: (context, _) {
                  return MealDetailScreen(
                    meal: widget.meal,
                  );
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: openContainer,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        widget.meal.imagePath,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      widget.meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 7,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      widget.meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${widget.meal.kiloCaloriesBurnt} kcal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.meal.timeTaken} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
