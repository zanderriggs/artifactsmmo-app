import 'dart:convert';

import 'package:artifactsmmo_app/models/data_model.dart';
import 'package:http/http.dart';

Future<List<Item>?> getInventory(Response response) async {
  var decodedResponse = json.decode(response.body);
  var data = Data.fromJson(decodedResponse);

  return data.apiResponse?.character?.inventory;
}
