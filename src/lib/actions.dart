import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

var server = GlobalConfiguration().getValue('server');
var token = GlobalConfiguration().getValue('token');
var character = GlobalConfiguration()
    .getValue('character'); // Eventually a passed in value?
var baseUrl = "$server/my/$character";

Future<Response> fight() async {
  final url = "$baseUrl/action/fight";

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
  final url = "$baseUrl/action/gathering";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Response response;

  try {
    response = await http.post(Uri.parse(url), headers: headers);
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}

Future<Response> move(
  int x,
  int y,
) async {
  final url = "$baseUrl/action/move";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = {"x": x, "y": y};

  Response response;

  try {
    response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}

Future bankRun() async {
  // TODO: Travel to bank location

  // TODO: Deposit all items

  // TODO: Return to previous location
}

Future<Response> craftItems(String itemCode, int itemCount) async {
  final url = "$baseUrl/action/crafting";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = {"code": itemCode, "quantity": itemCount};

  Response response;

  try {
    response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}

Future<Response> sell(String itemCode, int itemCount, int price) async {
  final url = "$baseUrl/action/ge/sell";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = {"code": itemCode, "quantity": itemCount, "price": price};

  Response response;

  try {
    response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }

  return response;
}
