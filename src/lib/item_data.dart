import 'dart:convert';

import 'package:artifactsmmo_app/models/get_item_response.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

var server = GlobalConfiguration().getValue('server');
var token = GlobalConfiguration().getValue('token');
var character = GlobalConfiguration().getValue('character');

Future<Response> getItemData(
  String itemCode,
) async {
  print("Getting item data");
  final url = "$server/items/$itemCode";
  print(url);

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response response;

  try {
    response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}

Future<int?> getItemSellPrice(String itemCode) async {
  var itemDataResponse = await getItemData(itemCode);

  if (itemDataResponse.statusCode == 200) {
    var decodedResponse = json.decode(itemDataResponse.body);
    var data = GetItemResponse.fromJson(decodedResponse);

    return data.itemData?.grandExchange?.sellPrice;
  } else {
    debugPrint("An error occurred while retrieving the item sell price.");
    return 0;
  }
}
