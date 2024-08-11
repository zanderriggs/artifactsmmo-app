class Data {
  ApiResponse? apiResponse;

  Data(this.apiResponse);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        json['data'] != null ? ApiResponse.fromJson(json['data']) : null);
  }
}

class ApiResponse {
  Cooldown? cooldown;
  Fight? fight;
  Character? character;

  ApiResponse({this.cooldown, this.fight, this.character});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      cooldown:
          json['cooldown'] != null ? Cooldown.fromJson(json['cooldown']) : null,
      fight: json['fight'] != null ? Fight.fromJson(json['fight']) : null,
      character: json['character'] != null
          ? Character.fromJson(json['character'])
          : null,
    );
  }
}

class Cooldown {
  int? totalSeconds;
  int? remainingSeconds;
  String? startedAt;
  String? expiration;
  String? movement;

  Cooldown({
    this.totalSeconds,
    this.remainingSeconds,
    this.startedAt,
    this.expiration,
    this.movement,
  });

  factory Cooldown.fromJson(Map<String, dynamic> json) {
    return Cooldown(
      totalSeconds: json['total_seconds'],
      remainingSeconds: json['remaining_seconds'],
      startedAt: json['started_at'],
      expiration: json['expiration'],
      movement: json['movement'],
    );
  }
}

class Fight {
  int? xp;
  int? gold;
  //drops
  int? turns;
  String? result;

  Fight({
    this.xp,
    this.gold,
    this.turns,
    this.result,
  });

  factory Fight.fromJson(Map<String, dynamic> json) {
    return Fight(
      xp: json['xp'],
      gold: json['gold'],
      turns: json['turns'],
      result: json['result'],
    );
  }
}

class Character {
  String? name;
  int? level;
  int? gold;
  List<Item>? inventory;

  Character({
    this.name,
    this.level,
    this.gold,
    this.inventory,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      level: json['level'],
      gold: json['gold'],
      inventory: (json['inventory'] as List<dynamic>?)
          ?.map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Item {
  int? slot;
  String? code;
  int? quantity;

  Item({
    this.slot,
    this.code,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      slot: json['slot'],
      code: json['code'],
      quantity: json['quantity'],
    );
  }
}
