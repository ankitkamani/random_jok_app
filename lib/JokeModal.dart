
import 'dart:convert';

RandomjokeModal randomjokeModalFromJson(String str) => RandomjokeModal.fromJson(json.decode(str));

String randomjokeModalToJson(RandomjokeModal data) => json.encode(data.toJson());

class RandomjokeModal {
  List<String>? categories;
  DateTime? createdAt;
  String? iconUrl;
  String? id;
  DateTime? updatedAt;
  String? url;
  String? value;

  RandomjokeModal({
    this.categories,
    this.createdAt,
    this.iconUrl,
    this.id,
    this.updatedAt,
    this.url,
    this.value,
  });

  factory RandomjokeModal.fromJson(Map<String, dynamic> json) => RandomjokeModal(
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    iconUrl: json["icon_url"],
    id: json["id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    url: json["url"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "icon_url": iconUrl,
    "id": id,
    "updated_at": updatedAt?.toIso8601String(),
    "url": url,
    "value": value,
  };
}
