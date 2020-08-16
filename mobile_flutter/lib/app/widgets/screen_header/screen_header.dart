import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter/app/screens/home/home.dart';
import 'package:mobile_flutter/app/utils/ui_utils.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final Widget rightWidget;
  final Widget child;

  const ScreenHeader({Key key, this.title, this.rightWidget, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.05,
                  horizontal: constraints.maxWidth * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      child: Image.asset('assets/images/icons/back.png'),
                    ),
                  ),
                  Container(
                    child: Image.asset('assets/images/logo.png'),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.08),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          this.title,
                          style: GoogleFonts.getFont('Archivo',
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                              fontSize: UiUtils.getSizeValue(
                                  value: constraints.maxHeight * 0.15,
                                  max: 40,
                                  min: 20),
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        child: this.rightWidget,
                      ),
                    ],
                  ),
                  Container(
                    child: this.child,
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
