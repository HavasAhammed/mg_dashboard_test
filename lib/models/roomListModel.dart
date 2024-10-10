class RoomListModel {
  String? id;
  String? category;
  String? type;
  // Type? type;

  RoomListModel({
    this.id,
    this.category,
    this.type,
  });

  factory RoomListModel.fromJson(Map<String, dynamic> json) => RoomListModel(
        id: json["Id"],
        category: json["Category"],
        type: json["Type"],
        // type: typeValues.map[json["Type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Category": category,
        "Type": type,
        // "Type": typeValues.reverse[type],
      };
}

enum Type {
  NEW_BLOCK_SIXTH_FLOOR,
  THE_0_OLD_BLOCK_GROUND_FLOOR,
  THE_1_OLD_BLOCK_FIRST_FLOOR,
  THE_2_OLD_BLOCK_SECOND_FLOOR,
  THE_3_OLD_BLOCK_THIRD_FLOOR,
  THE_5_NEW_BLOCK_SECOND_FLOOR,
  THE_7_NEW_BLOCK_FOURTH_FLOOR
}

final typeValues = EnumValues({
  "NEW BLOCK SIXTH FLOOR": Type.NEW_BLOCK_SIXTH_FLOOR,
  "0.OLD BLOCK GROUND FLOOR": Type.THE_0_OLD_BLOCK_GROUND_FLOOR,
  "1.OLD BLOCK FIRST FLOOR": Type.THE_1_OLD_BLOCK_FIRST_FLOOR,
  "2.OLD BLOCK SECOND FLOOR": Type.THE_2_OLD_BLOCK_SECOND_FLOOR,
  "3.OLD BLOCK THIRD FLOOR": Type.THE_3_OLD_BLOCK_THIRD_FLOOR,
  "5.NEW BLOCK SECOND FLOOR": Type.THE_5_NEW_BLOCK_SECOND_FLOOR,
  "7.NEW BLOCK FOURTH FLOOR": Type.THE_7_NEW_BLOCK_FOURTH_FLOOR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
