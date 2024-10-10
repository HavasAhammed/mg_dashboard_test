class PharmacyPurchaseModel {
    int? tNo;
    DateTime? tDate;
    String? supplierInvoiceNumber;
    DateTime? supplierInvoiceDate;
    String? supplierName;
    int? amount;

    PharmacyPurchaseModel({
        this.tNo,
        this.tDate,
        this.supplierInvoiceNumber,
        this.supplierInvoiceDate,
        this.supplierName,
        this.amount,
    });

    factory PharmacyPurchaseModel.fromJson(Map<String, dynamic> json) => PharmacyPurchaseModel(
        tNo: json["TNo"],
        tDate: json["TDate"] == null ? null : DateTime.parse(json["TDate"]),
        supplierInvoiceNumber: json["SupplierInvoiceNumber"],
        supplierInvoiceDate: json["SupplierInvoiceDate"] == null ? null : DateTime.parse(json["SupplierInvoiceDate"]),
        supplierName: json["SupplierName"],
        amount: json["Amount"],
    );

    Map<String, dynamic> toJson() => {
        "TNo": tNo,
        "TDate": tDate?.toIso8601String(),
        "SupplierInvoiceNumber": supplierInvoiceNumber,
        "SupplierInvoiceDate": supplierInvoiceDate?.toIso8601String(),
        "SupplierName": supplierName,
        "Amount": amount,
    };
}