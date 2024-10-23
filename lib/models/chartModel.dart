class ChartModel {
  double? amount;
  int? year;
  int? month;

  ChartModel({
    this.amount,
    this.year,
    this.month,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        amount: json["Amount"],
        year: json["Year"],
        month: json["Month"],
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "Year": year,
        "Month": month,
      };
}
