import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:convert';
import 'SlackNotificationService.dart';

class UpdateInformationDBService {

  static Future updateProfile(Map data) async {
    var box = await Hive.openBox('app_data');
    Map datos = {};

    datos.addAll(data);
    var body = json.encode(datos);
    http.Response response = await http.post(
        Uri.parse('https://qqv.oex.mybluehost.me/api/profile/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: body
    );

    SlackNotificationService.sendSlackMessage(response.body.toString());

    return response;
  }

}