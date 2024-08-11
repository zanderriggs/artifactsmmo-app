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
  // character

  ApiResponse({this.cooldown, this.fight});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      cooldown:
          json['cooldown'] != null ? Cooldown.fromJson(json['cooldown']) : null,
      fight: json['fight'] != null ? Fight.fromJson(json['fight']) : null,
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

class Character {}
