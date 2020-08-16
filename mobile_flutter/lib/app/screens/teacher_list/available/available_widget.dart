import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/services/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter/app/services/local_storage.dart';
import 'package:mobile_flutter/app/utils/constants.dart';
import 'package:mobile_flutter/app/utils/ui_utils.dart';
import 'package:mobile_flutter/app/widgets/class_item/class_item.dart';
import 'package:mobile_flutter/app/widgets/screen_header/screen_header.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AvailableWidget extends StatefulWidget {
  @override
  _AvailableWidgetState createState() => _AvailableWidgetState();
}

class _AvailableWidgetState extends State<AvailableWidget> {
  final Api api = new Api();
  final format = new DateFormat("hh:mm a");
  final _formKey = GlobalKey<FormState>();
  bool isFilterOpened = false;
  bool isFormValid = true;
  String subject;
  String weekDay;
  DateTime time = DateTime.now();
  List<dynamic> teachers = [];
  List<dynamic> _favorites;

  _getTeachers() async {
    if (!_formKey.currentState.validate()) {
      return setState(() {
        this.isFormValid = false;
      });
    }
    var data = await api.listAllClasses(
        subject: this.subject,
        weekDay: this.weekDay,
        time: DateFormat.Hm().format(this.time));

    setState(() {
      this.teachers = data;
      this.subject = null;
      this.weekDay = null;
      this.time = DateTime.now();
      this.isFilterOpened = false;
    });
  }

  bool checkisFavorite(Map<String, dynamic> teacher) {
    for (var item in _favorites) {
      if (item['id'] == teacher['id']) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _favorites = await LocalStorage.loadFavorite();
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
                          title: 'Proffys Disponíveis',
                          rightWidget: IconButton(
                            icon: Icon(
                              Icons.filter_list,
                              color: Colors.white,
                              size: UiUtils.getSizeValue(
                                  value: constraints.maxHeight * 0.05,
                                  max: 50,
                                  min: 20),
                            ),
                            onPressed: () {
                              setState(() {
                                this.isFilterOpened = !this.isFilterOpened;
                                this.isFormValid = true;
                              });
                            },
                          ),
                        ),
                      ),
                      isFilterOpened
                          ? Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              color: Theme.of(context).primaryColor,
                              margin: EdgeInsets.only(
                                top: constraints.maxHeight * 0.25,
                              ),
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth * 0.05,
                                  right: constraints.maxWidth * 0.05),
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DropdownButtonFormField(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return '';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Matéria",
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                items: SUBJECTS_CONTANTS,
                                                onChanged: (value) {
                                                  setState(() {
                                                    this.subject = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DropdownButtonFormField(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return '';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Dia da Semana",
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                items: WEEK_DAYS,
                                                onChanged: (value) {
                                                  setState(() {
                                                    this.weekDay = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                        Container(
                                          width: constraints.maxWidth,
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DateTimeField(
                                              validator: (value) {
                                                if (value == null) {
                                                  return '';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: "Horário",
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              format: format,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.time = value;
                                                });
                                              },
                                              onShowPicker: (context,
                                                  currentValue) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                    currentValue ??
                                                        DateTime.now(),
                                                  ),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: ButtonTheme(
                                            height: 60,
                                            minWidth: constraints.maxWidth,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(8),
                                            ),
                                            child: RaisedButton(
                                              color: Color(0xff04D361),
                                              onPressed: () {
                                                _getTeachers();
                                              },
                                              child: Text(
                                                "Filtrar",
                                                style: GoogleFonts.getFont(
                                                  'Archivo',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      UiUtils.getSizeValue(
                                                          value: constraints
                                                                  .maxWidth *
                                                              0.05,
                                                          max: 18,
                                                          min: 12),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
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
                                            isFavorite: this.checkisFavorite(
                                                this.teachers[index]),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                        top: constraints.maxHeight * 0.25,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              'Nenhum proffy encontrado!',
                                              style: GoogleFonts.getFont(
                                                  'Archivo',
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      UiUtils.getSizeValue(
                                                          value: constraints
                                                                  .maxHeight *
                                                              0.02,
                                                          max: 40,
                                                          min: 20),
                                                  color: Color(0xffC1BCCC)),
                                            ),
                                          ),
                                          Container(
                                            width: constraints.maxWidth * 0.5,
                                            child: Text(
                                              'utilize o filtro para encontrar seus proffys!',
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  letterSpacing: 1,
                                                  fontSize:
                                                      UiUtils.getSizeValue(
                                                          value: constraints
                                                                  .maxHeight *
                                                              0.01,
                                                          max: 20,
                                                          min: 15),
                                                  color: Color(0xffC1BCCC)),
                                            ),
                                          ),
                                        ],
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
