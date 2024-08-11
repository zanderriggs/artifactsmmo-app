//Use node fight_loop.js in the terminal for execute the script.
import 'dart:convert';

import 'package:artifactsmmo_app/actions.dart';
import 'package:artifactsmmo_app/character_data.dart';
import 'package:artifactsmmo_app/models/data_model.dart';
import 'package:artifactsmmo_app/utility.dart';
import 'package:http/http.dart';

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

Future<Response> gatherLoop() async {
  // Gather
  var response = await gather();

  if (response.statusCode == 498) {
    print('The character cannot be found on your account.');
    return response;
  } else if (response.statusCode == 497) {
    print("Your character's inventory is full.");
    return response;
  } else if (response.statusCode == 499) {
    print('Your character is in cooldown.');
    return response;
  } else if (response.statusCode == 598) {
    print('No resource on this map.');
    return response;
  } else if (response.statusCode != 200) {
    print('An error occurred while gatering the resource.');
    return response;
  }

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var parsedResponse = Data.fromJson(data);

    print("Your character successfully gathered the resource.");

    cooldown = parsedResponse.apiResponse?.cooldown?.totalSeconds;
    print("Retreived cooldown timer: $cooldown");
    await Future.delayed(Duration(seconds: cooldown));
    return await gatherLoop();
  }
  return Response("", 500);
}

Future levelCrafting() async {
  // Move to mining resource

  // Gather until inventory full

  // Move to refinery
  // Refine gathered resource

  // Move to craft location
  // Craft highest level item possible with refined resource

  // Move to Grand Exchange
  // Sell items
}

Future levelCooking() async {
  // Move to fishing
  // TODO: Make map instead of hardcoding values
  final moveFishingResult = await move(4, 2);

  if (moveFishingResult.statusCode == 404) {
    print('The map location could not be found.');
    return;
  } else if (moveFishingResult.statusCode == 486) {
    print('An action is already in progress by your character.');
    return;
  } else if (moveFishingResult.statusCode == 490) {
    print('The character is already at the given destination.');
  } else if (moveFishingResult.statusCode == 498) {
    print('The character cannot be found on your account.');
    return;
  } else if (moveFishingResult.statusCode == 499) {
    print('Your character is in cooldown.');
    return;
  } else if (moveFishingResult.statusCode != 200) {
    print('An error occurred while moving to the location.');
    return;
  }

  if (moveFishingResult.statusCode == 200 ||
      moveFishingResult.statusCode == 490) {
    print("Moved to fishing location");

    // Cooldown
    await waitCooldown(moveFishingResult);

    // Fish until inventory full
    var fishResult = await gatherLoop();

    if (fishResult.statusCode == 497) {
      // Cooldown
      await waitCooldown(fishResult);

      // Move to Workshop (Crafting)
      final moveWorkshopResult = await move(1, 1);

      if (moveWorkshopResult.statusCode == 200) {
        print("Moved to workshop (cooking)");
        // Cooldown
        await waitCooldown(moveWorkshopResult);

        // Get number of fish in inventory
        var inventory = await getInventory(moveWorkshopResult);

        // TODO: Fix hardcoded nonsense
        var quantity =
            inventory?.firstWhere((item) => item.code == "gudgeon").quantity ??
                0;
        print("Fish quantity: $quantity");

        // Cook all fish
        // TODO: Fix hardcoded nonsense
        var craftResults = await craftItems('cooked_gudgeon', quantity);

        if (craftResults.statusCode == 200) {
          // Cooldown
          await waitCooldown(craftResults);

          // Move to Grand Exchange and sell fish
          var grandExchangeMoveResult = await move(5, 1);

          if (grandExchangeMoveResult.statusCode == 200) {
            await waitCooldown(grandExchangeMoveResult);

            // Sell fish
            // TODO: Fix hardcoded nonsense
            var sellFishResult = await sell("cooked_gudgeon", quantity, 150);

            if (sellFishResult.statusCode == 200) {
              print("You did it. You sold all the fish you caught. Loop it.");
              await waitCooldown(sellFishResult);

              levelCooking();
            }
            print("An error occurred while selling the fish.");
            return;
          }
        }
      }
    }
  }
}
