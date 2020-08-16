import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter/app/screens/give_classes/give_classes.dart';
import 'package:mobile_flutter/app/screens/teacher_list/teacher_list.dart';
import 'package:mobile_flutter/app/services/api.dart';
import 'package:mobile_flutter/app/utils/ui_utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeScreen> {
  final Api api = new Api();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.3,
                            padding: EdgeInsets.only(
                                top: constraints.maxHeight * 0.04),
                            child: Center(
                              child: Image.asset(
                                'assets/images/landing.png',
                              ),
                            ),
                          ),
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.08,
                                      vertical: constraints.maxHeight * 0.08),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Seja bem-vindo.',
                                        style: GoogleFonts.getFont('Poppins',
                                            letterSpacing: 1,
                                            fontSize: UiUtils.getSizeValue(
                                                value: constraints.maxHeight *
                                                    0.05,
                                                max: 36,
                                                min: 24),
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'O que deseja fazer?',
                                        style: GoogleFonts.getFont('Poppins',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            fontSize: UiUtils.getSizeValue(
                                                value: constraints.maxHeight *
                                                    0.05,
                                                max: 36,
                                                min: 24),
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.08,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ButtonTheme(
                                        minWidth: constraints.maxWidth * 0.38,
                                        height: constraints.maxHeight * 0.25,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  constraints.maxHeight * 0.02),
                                        ),
                                        child: RaisedButton(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TeacherListScreen(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.book,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color,
                                                size: constraints.maxHeight *
                                                    0.04,
                                              ),
                                              Text(
                                                'Estudar',
                                                style: GoogleFonts.getFont(
                                                  'Archivo',
                                                  fontSize:
                                                      UiUtils.getSizeValue(
                                                          value: constraints
                                                                  .maxHeight *
                                                              0.04,
                                                          max: 28,
                                                          min: 18),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      ButtonTheme(
                                        minWidth: constraints.maxWidth * 0.38,
                                        height: constraints.maxHeight * 0.25,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  constraints.maxHeight * 0.02),
                                        ),
                                        child: RaisedButton(
                                          color: Theme.of(context).buttonColor,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GiveClassesScreen(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(Icons.tv,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .color,
                                                  size: constraints.maxHeight *
                                                      0.04),
                                              Text(
                                                'Dar aulas',
                                                style: GoogleFonts.getFont(
                                                  'Archivo',
                                                  fontSize:
                                                      UiUtils.getSizeValue(
                                                          value: constraints
                                                                  .maxHeight *
                                                              0.04,
                                                          max: 28,
                                                          min: 18),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                FutureBuilder(
                                  future: api.getTotalConnections(),
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              constraints.maxWidth * 0.08,
                                          vertical:
                                              constraints.maxHeight * 0.05),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Total de ${snapshot.data} conexões já realizadas ',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              fontSize: UiUtils.getSizeValue(
                                                  value: constraints.maxHeight *
                                                      0.02,
                                                  max: 16,
                                                  min: 12),
                                              color: Color(0xffD4C2FF),
                                            ),
                                          ),
                                          Icon(
                                            Icons.favorite,
                                            color: Color(0xffD4C2FF),
                                            size: UiUtils.getSizeValue(
                                                value: constraints.maxHeight *
                                                    0.02,
                                                max: 16,
                                                min: 12),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
