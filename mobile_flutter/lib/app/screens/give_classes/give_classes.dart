import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter/app/utils/ui_utils.dart';

class GiveClassesScreen extends StatelessWidget {
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
                      return Stack(
                        children: <Widget>[
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: Image.asset(
                              'assets/images/give-classes-background.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.08),
                                width: constraints.maxWidth * 0.45,
                                child: Text(
                                  "Quer ser um Proffy?",
                                  style: GoogleFonts.getFont('Archivo',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: UiUtils.getSizeValue(
                                          value: constraints.maxHeight * 0.05,
                                          max: 36,
                                          min: 24),
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.08,
                                    top: constraints.maxHeight * 0.02),
                                width: constraints.maxWidth * 0.6,
                                child: Text(
                                  "Para começar, você precisa se cadastrar como professor na nossa plataforma web.",
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    letterSpacing: 1,
                                    fontSize: UiUtils.getSizeValue(
                                        value: constraints.maxHeight * 0.02,
                                        max: 20,
                                        min: 14),
                                    color: Color(0xffD4C2FF),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.08,
                    right: size.width * 0.08,
                    bottom: size.height * 0.05,
                    top: size.height * 0.05),
                child: ButtonTheme(
                  minWidth: size.width,
                  height: UiUtils.getSizeValue(
                      value: size.height * 0.1, max: 80, min: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8),
                  ),
                  child: RaisedButton(
                    color: Color(0xff04D361),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Tudo bem",
                      style: GoogleFonts.getFont(
                        'Archivo',
                        fontWeight: FontWeight.w700,
                        fontSize: UiUtils.getSizeValue(
                            value: size.height * 0.02, max: 24, min: 16),
                        color: Colors.white,
                      ),
                    ),
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
