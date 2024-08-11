import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

var server = GlobalConfiguration().getValue('server');
var token = GlobalConfiguration().getValue('token');
var character = GlobalConfiguration().getValue('character');
var baseUrl = "$server/my/$character";

Future<Response> getItemData(
  String itemCode,
) async {
  final url = "$baseUrl/items/$itemCode";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response response;

  try {
    response = await http.post(
      Uri.parse(url),
      headers: headers,
    );
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}
