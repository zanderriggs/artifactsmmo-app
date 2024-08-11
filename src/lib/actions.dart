import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Response> fight(String token, String server, String character) async {
  final url = "$server/my/$character/action/fight";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response response;

  try {
    response = await http.post(Uri.parse(url), headers: headers);
  } catch (ex) {
    print("An error occurred. $ex");
    return Response("", 500);
  }
  print("Response received");
  return response;
}

Future<Response> gather(String token, String server, String character) async {
  final url = "$server/my/$character/action/gathering";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response response;

  try {
    response = await http.post(Uri.parse(url), headers: headers);
  } catch (ex) {
    print("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}
