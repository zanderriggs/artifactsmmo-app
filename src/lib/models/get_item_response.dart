import 'package:artifactsmmo_app/models/data_model.dart';

class GetItemResponse {
  ItemData? itemData;

  GetItemResponse({
    this.itemData,
  });

  factory GetItemResponse.fromJson(Map<String, dynamic> json) {
    return GetItemResponse(
      itemData: json['data'] != null ? ItemData.fromJson(json['data']) : null,
    );
  }
}

class ItemData {
  Item? item;
  GrandExchange? grandExchange;

  ItemData({this.item, this.grandExchange});

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      grandExchange:
          json['ge'] != null ? GrandExchange.fromJson(json['ge']) : null,
    );
  }
}
