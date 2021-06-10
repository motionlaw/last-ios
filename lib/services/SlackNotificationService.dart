import 'dart:convert';
import 'package:http/http.dart' as http;

class SlackNotificationService{
  static Future sendSlackMessage(String messageText) async {
    var url = 'https://hooks.slack.com/services/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';

    Map<String, String> requestHeader = {
      'Content-type': 'application/json',
    };

    var request = {
      'text': messageText,
      'icon_emoji': ':boom:'
    };

    var result = http
        .post(Uri.parse(url), body: json.encode(request), headers: requestHeader)
        .then((response) {
      print(response.body);
    });
    print(result);
  }
}