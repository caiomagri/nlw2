import 'dart:io';
import 'package:mobile_flutter/app/services/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/services/local_storage.dart';
import 'package:mobile_flutter/app/utils/ui_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassItem extends StatefulWidget {
  final Map<String, dynamic> teacher;
  bool isFavorite;

  ClassItem({this.teacher, this.isFavorite: false});

  @override
  _ClassItemState createState() =>
      _ClassItemState(teacher: this.teacher, isFavorite: this.isFavorite);
}

class _ClassItemState extends State<ClassItem> {
  final Api api = new Api();
  final Map<String, dynamic> teacher;
  bool isFavorite;

  _ClassItemState({this.teacher, this.isFavorite: false});

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      api.makeConnection(this.teacher['id']);
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffE6E6F0)),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffE6E6F0),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.04,
                      horizontal: size.width * 0.05),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              width: UiUtils.getSizeValue(
                                  value: constraints.maxWidth * 0.15,
                                  max: 70,
                                  min: 50),
                              height: UiUtils.getSizeValue(
                                  value: constraints.maxWidth * 0.15,
                                  max: 70,
                                  min: 50),
                              child: Image.network(
                                this.widget.teacher['avatar'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: constraints.maxWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    this.widget.teacher['name'],
                                    style: GoogleFonts.getFont(
                                      'Archivo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: UiUtils.getSizeValue(
                                          value: constraints.maxHeight * 0.05,
                                          max: 16,
                                          min: 16),
                                      color: Color(0xff32264D),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    this.widget.teacher['subject'],
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.normal,
                                      fontSize: UiUtils.getSizeValue(
                                          value: constraints.maxWidth * 0.01,
                                          max: 18,
                                          min: 12),
                                      color: Color(0xff6A6180),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          this.widget.teacher['bio'],
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: UiUtils.getSizeValue(
                                value: constraints.maxWidth * 0.01,
                                max: 18,
                                min: 12),
                            color: Color(0xff6A6180),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFAFAFC),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Preço/hora",
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontSize: 14,
                                color: Color(0xff6A6180),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: Text(
                                "R\$ ${this.widget.teacher['cost']}",
                                style: GoogleFonts.getFont('Archivo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              height: 60,
                              minWidth: constraints.maxWidth * 0.2,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8),
                              ),
                              child: RaisedButton(
                                  color: this.isFavorite
                                      ? Color(0xffE33D3D)
                                      : Theme.of(context).primaryColorLight,
                                  onPressed: () {
                                    if (this.isFavorite) {
                                      LocalStorage.removeFavorite(
                                          this.widget.teacher['id']);
                                    } else {
                                      LocalStorage.addFavorite(this.teacher);
                                    }
                                    setState(() {
                                      this.isFavorite = !this.isFavorite;
                                    });
                                  },
                                  child: this.isFavorite
                                      ? Container(
                                          width: UiUtils.getSizeValue(
                                              value: size.height * 0.1,
                                              max: 35,
                                              min: 12),
                                          height: UiUtils.getSizeValue(
                                              value: size.height * 0.1,
                                              max: 35,
                                              min: 12),
                                          child: Image.asset(
                                              'assets/images/icons/unfavorite.png'),
                                        )
                                      : Container(
                                          width: UiUtils.getSizeValue(
                                              value: size.height * 0.1,
                                              max: 35,
                                              min: 12),
                                          height: UiUtils.getSizeValue(
                                              value: size.height * 0.1,
                                              max: 35,
                                              min: 12),
                                          child: Image.asset(
                                              'assets/images/icons/heart-outline.png'),
                                        )),
                            ),
                            ButtonTheme(
                              height: 60,
                              minWidth: constraints.maxWidth * 0.6,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8),
                              ),
                              child: RaisedButton(
                                color: Color(0xff04D361),
                                onPressed: () {
                                  this.launchWhatsApp(
                                      phone: this.teacher['whatsapp'],
                                      message: 'Olá');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: size.width * 0.05),
                                      width: UiUtils.getSizeValue(
                                          value: constraints.maxWidth * 0.1,
                                          max: 20,
                                          min: 12),
                                      height: UiUtils.getSizeValue(
                                          value: constraints.maxWidth * 0.1,
                                          max: 20,
                                          min: 12),
                                      child: Image.asset(
                                          'assets/images/icons/whatsapp.png'),
                                    ),
                                    Text(
                                      "Entrar em contato",
                                      style: GoogleFonts.getFont(
                                        'Archivo',
                                        fontWeight: FontWeight.w700,
                                        fontSize: UiUtils.getSizeValue(
                                            value: constraints.maxWidth * 0.05,
                                            max: 18,
                                            min: 12),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
