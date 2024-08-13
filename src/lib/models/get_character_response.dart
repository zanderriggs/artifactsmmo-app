import 'package:artifactsmmo_app/models/data_model.dart';

class GetCharacterResponse {
  Character? character;

  GetCharacterResponse({this.character});

  factory GetCharacterResponse.fromJson(Map<String, dynamic> json) {
    return GetCharacterResponse(
      character: json['data'] != null ? Character.fromJson(json['data']) : null,
    );
  }
}
