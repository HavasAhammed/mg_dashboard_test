class ExpiryMedicineModel {
  StockSection? stockSection;
  String? itemName;
  String? batchNumber;
  double? amount;
  DateTime? expDate;
  double? stock;

  ExpiryMedicineModel({
    this.stockSection,
    this.itemName,
    this.batchNumber,
    this.amount,
    this.expDate,
    this.stock,
  });

  factory ExpiryMedicineModel.fromJson(Map<String, dynamic> json) =>
      ExpiryMedicineModel(
        stockSection: stockSectionValues.map[json["StockSection"]]!,
        itemName: json["ItemName"],
        batchNumber: json["BatchNumber"],
        amount: json["Amount"]?.toDouble(),
        expDate:
            json["ExpDate"] == null ? null : DateTime.parse(json["ExpDate"]),
        stock: json["Stock"],
      );

  Map<String, dynamic> toJson() => {
        "StockSection": stockSectionValues.reverse[stockSection],
        "ItemName": itemName,
        "BatchNumber": batchNumber,
        "Amount": amount,
        "ExpDate": expDate?.toIso8601String(),
        "Stock": stock,
      };
}

enum StockSection { D_STORE, IP_PHARMACY, MAIN_PHARMACY, NEW_BLOCK }

final stockSectionValues = EnumValues({
  "D-STORE": StockSection.D_STORE,
  "IP PHARMACY": StockSection.IP_PHARMACY,
  "MAIN PHARMACY": StockSection.MAIN_PHARMACY,
  "NEW BLOCK": StockSection.NEW_BLOCK
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
