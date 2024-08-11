import 'dart:convert';

import 'package:artifactsmmo_app/models/data_model.dart';
import 'package:http/http.dart';

Future waitCooldown(Response response) async {
  var data = json.decode(response.body);
  var parsedResponse = Data.fromJson(data);
  var cooldown = parsedResponse.apiResponse?.cooldown?.totalSeconds ?? 0;
  print("Waiting cooldown timer: $cooldown");
  await Future.delayed(Duration(seconds: cooldown));
}
