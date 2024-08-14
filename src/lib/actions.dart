import 'dart:convert';

import 'package:artifactsmmo_app/character_data.dart';
import 'package:artifactsmmo_app/item_data.dart';
import 'package:artifactsmmo_app/models/data_model.dart';
import 'package:artifactsmmo_app/utility.dart';
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

  final body =
      json.encode({"code": itemCode, "quantity": itemCount, "price": price});
  print(body);
  try {
    Response response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    // Checking if the response is not 2xx, indicating a problem
    if (response.statusCode >= 400) {
      debugPrint("Request failed with status: ${response.statusCode}");
      print(response.body);
    }

    return response;
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }
}

Future sellAllFish() async {
  // Get item data
  var itemSellQuantity = await getItemQuantity("cooked_shrimp");
  print("Sell quantity: $itemSellQuantity");

  if (itemSellQuantity == null) {
    debugPrint("An error occurred while retrieving item quantity.");
    return;
  }

  // Sell Fish
  var sellCounter = itemSellQuantity;
  while (sellCounter > 0) {
    var itemSellPrice = await getItemSellPrice("cooked_shrimp");
    print("Sell Price: $itemSellPrice");
    if (itemSellPrice == 0) {
      debugPrint(
          "No, for real, an error occured while getting the item price.");
      return;
    }

    if (sellCounter > 50) {
      final sellResult = await sell("cooked_shrimp", 50, itemSellPrice ?? 0);
      if (sellResult.statusCode == 200) {
        sellCounter -= 50;
        await waitCooldown(sellResult);
      } else {
        return;
      }
    } else {
      final sellResult =
          await sell("cooked_shrimp", sellCounter, itemSellPrice ?? 0);
      if (sellResult.statusCode == 200) {
        sellCounter -= sellCounter;
        await waitCooldown(sellResult);
      } else {
        return;
      }
    }
  }
}

Future depositAllItemsToBank() async {
  final inventoryList = await getInventory();

  if (inventoryList == null) {
    debugPrint("An error ocurred while getting inventory data.");
    return;
  }

  for (var item in inventoryList) {
    var depositResult = await depositItem(item);

    await waitCooldown(depositResult);
    if (depositResult.statusCode >= 400) {
      debugPrint(
          "An error ocurred while depositing item. ${depositResult.statusCode} Item: ${item.code}");
      return;
    }
  }
}

Future<Response> depositItem(InventoryItem item) async {
  final url = "$baseUrl/action/bank/deposit";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = json.encode({
    "code": item.code,
    "quantity": item.quantity,
  });

  try {
    Response response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    // Checking if the response is not 2xx, indicating a problem
    if (response.statusCode >= 400) {
      debugPrint(
          "Request failed with status: ${response.statusCode} {${item.code}, ${item.quantity}}");
      print(response.body);
    }

    return response;
  } catch (ex) {
    debugPrint("An error occurred. $ex");
    return Response("", 500);
  }
}
