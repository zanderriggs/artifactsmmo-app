//Use node fight_loop.js in the terminal for execute the script.
import 'dart:convert';

import 'package:artifactsmmo_app/actions.dart';
import 'package:artifactsmmo_app/models/data_model.dart';

var cooldown;

fightLoop() async {
  // Fight
  final response = await fight();

  // TODO: Turn these into enums or something
  if (response.statusCode == 498) {
    print('The character cannot be found on your account.');
    return;
  } else if (response.statusCode == 497) {
    print("Your character's inventory is full.");
    // bankRun();
    return;
  } else if (response.statusCode == 499) {
    print('Your character is in cooldown.');
    return;
  } else if (response.statusCode == 598) {
    print('No monster on this map.');
    return;
  } else if (response.statusCode != 200) {
    print('An error occurred during the fight.');
    return;
  }

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var parsedResponse = Data.fromJson(data);

    var fightResult = parsedResponse.apiResponse?.fight?.result;
    print("The fight ended successfully. You have $fightResult.");

    cooldown = parsedResponse.apiResponse?.cooldown?.totalSeconds;
    print("Retreived cooldown timer: $cooldown");
    await Future.delayed(Duration(seconds: cooldown));
    fightLoop();
  }
}

Future gatherLoop() async {
  // Gather
  var response = await gather();

  print("Response from gather method: ${response.statusCode}");

  if (response.statusCode == 498) {
    print('The character cannot be found on your account.');
    return;
  } else if (response.statusCode == 497) {
    print("Your character's inventory is full.");
    // bankRun();
    return;
  } else if (response.statusCode == 499) {
    print('Your character is in cooldown.');
    return;
  } else if (response.statusCode == 598) {
    print('No resource on this map.');
    return;
  } else if (response.statusCode != 200) {
    print('An error occurred while gatering the resource.');
    return;
  }

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var parsedResponse = Data.fromJson(data);

    print("Your character successfully gathered the resource.");

    cooldown = parsedResponse.apiResponse?.cooldown?.totalSeconds;
    print("Retreived cooldown timer: $cooldown");
    await Future.delayed(Duration(seconds: cooldown));
    return gatherLoop();
  }
}

Future bankRun() async {
  // TODO: Travel to bank location

  // TODO: Deposit all items

  // TODO: Return to previous location
}
