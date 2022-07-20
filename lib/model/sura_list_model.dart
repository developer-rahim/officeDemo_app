// To parse this JSON data, do
//
//     final suraListModel = suraListModelFromJson(jsonString);

import 'dart:convert';

List<SuraListModel> suraListModelFromJson(String str) => List<SuraListModel>.from(json.decode(str).map((x) => SuraListModel.fromJson(x)));

String suraListModelToJson(List<SuraListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SuraListModel {
    SuraListModel({
        required this.id,
        required this.name,
    
    });

    String id='1';
    String name='aa';

    factory SuraListModel.fromJson(Map<String, dynamic> json) => SuraListModel(
        id: json['id'],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
