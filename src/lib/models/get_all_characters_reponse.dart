import 'package:artifactsmmo_app/models/data_model.dart';

class GetAllCharactersResponse {
  List<Character>? characterList;

  GetAllCharactersResponse({this.characterList});

  factory GetAllCharactersResponse.fromJson(Map<String, dynamic> json) {
    return GetAllCharactersResponse(
      characterList: json['data'] != null
          ? (json['data'] as List)
              .map((characterJson) => Character.fromJson(characterJson))
              .toList()
          : null,
    );
  }
}
