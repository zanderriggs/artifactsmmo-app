import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

var server = GlobalConfiguration().getValue('server');
var token = GlobalConfiguration().getValue('token');
var character = GlobalConfiguration().getValue('character');

Future<Response> fight() async {
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

Future<Response> gather() async {
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

// TODO: Add move action
// Future<Response> move( int x, int y,) async {

// }