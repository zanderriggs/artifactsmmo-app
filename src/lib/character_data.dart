import 'dart:convert';

import 'package:artifactsmmo_app/models/data_model.dart';
import 'package:artifactsmmo_app/models/get_all_characters_reponse.dart';
import 'package:artifactsmmo_app/models/get_character_response.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

var server = GlobalConfiguration().getValue('server');
var token = GlobalConfiguration().getValue('token');
var character = GlobalConfiguration().getValue('character');

Future<Response> getCharacterData() async {
  print("Getting character data.");
  final url = "$server/characters/$character";

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

Future<List<Character>?> getMyCharacters() async {
  final url = "$server/my/characters/";

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
    return [];
  }

  var decodedResponse = json.decode(response.body);
  var characterList = GetAllCharactersResponse.fromJson(decodedResponse);

  return characterList.characterList;
}

// Returns ALL characters (don't use this)
Future<List<Character>?> getAllCharacters() async {
  final url = "$server/characters/";

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
    return [];
  }

  var decodedResponse = json.decode(response.body);
  var characterList = GetAllCharactersResponse.fromJson(decodedResponse);

  return characterList.characterList;
}

Future<List<InventoryItem>?> getInventory() async {
  final getCharacterDataResult = await getCharacterData();

  if (getCharacterDataResult.statusCode != 200) {
    debugPrint("An error occurred while retrieving character data.");
    return [];
  }

  var decodedResponse = json.decode(getCharacterDataResult.body);
  var data = GetCharacterResponse.fromJson(decodedResponse);

  return data.character?.inventory?.toList();
}

Future<int?> getItemQuantity(String itemCode) async {
  var getCharacterDataResult = await getCharacterData();

  if (getCharacterDataResult.statusCode != 200) {
    debugPrint("An error occurred while retrieving character data.");
    return 0;
  }

  var decodedResponse = json.decode(getCharacterDataResult.body);
  var data = GetCharacterResponse.fromJson(decodedResponse);
  var inventory = data.character?.inventory;

  var itemQuantity =
      inventory?.firstWhere((item) => item.code == itemCode).quantity;

  return itemQuantity;
}

// Future<Response> sellAllItems() async {
//   final characterDataResult = 
// }