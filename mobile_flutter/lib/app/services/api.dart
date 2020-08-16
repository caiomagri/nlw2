import 'package:dio/dio.dart';

class Api {
  static final Dio dio = new Dio(BaseOptions(
    baseUrl: "http://192.168.15.17:3333",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  static final Api _singleton = Api._internal();

  factory Api() {
    return _singleton;
  }

  Api._internal();

  Future<int> getTotalConnections() async {
    try {
      Response response = await dio.get('/connections');
      return response.data['total'];
    } catch (e) {
      print(e);
      return 0;
    }
  }

  void makeConnection(int teacherId) async {
    try {
      await dio.post('/connections', data: {'user_id': teacherId});
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> listAllClasses({weekDay, subject, time}) async {
    print({'week_day': weekDay, 'subject': subject, 'time': time});
    Response response = await dio.get('/classes', queryParameters: {
      'week_day': weekDay,
      'subject': subject,
      'time': time
    });
    if (response.statusCode == 200) {
      return response.data;
    }

    return [];
  }
}
