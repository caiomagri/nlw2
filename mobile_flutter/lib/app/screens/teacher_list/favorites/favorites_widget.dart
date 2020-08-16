import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter/app/services/local_storage.dart';
import 'package:mobile_flutter/app/utils/ui_utils.dart';
import 'package:mobile_flutter/app/widgets/class_item/class_item.dart';
import 'package:mobile_flutter/app/widgets/screen_header/screen_header.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  List<dynamic> teachers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var data = await LocalStorage.loadFavorite();
    setState(() {
      this.teachers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
                        height: constraints.maxHeight * 0.3,
                        child: ScreenHeader(
                          title: 'Meus proffys Favoritos',
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: Colors.transparent,
                        margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.25,
                            left: constraints.maxWidth * 0.05,
                            right: constraints.maxWidth * 0.05),
                        child: this.teachers.length > 0
                            ? ListView.builder(
                                itemCount: this.teachers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: ClassItem(
                                      teacher: this.teachers[index],
                                      isFavorite: true,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                  top: constraints.maxHeight * 0.25,
                                ),
                                child: Center(
                                  child: Text(
                                    'Nenhum proffy favorito!',
                                    style: GoogleFonts.getFont('Archivo',
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: UiUtils.getSizeValue(
                                            value: constraints.maxHeight * 0.02,
                                            max: 40,
                                            min: 20),
                                        color: Color(0xffC1BCCC)),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
