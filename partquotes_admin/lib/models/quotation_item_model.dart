class QuotationItem {
  final String quotationBy;
  final String date;
  final bool status;
  final List<dynamic> items;

  QuotationItem({
    required this.quotationBy,
    required this.date,
    required this.status,
    required this.items,
  });

  factory QuotationItem.fromJson(Map<String, dynamic> json) {
    return QuotationItem(
      quotationBy: json['quotationBy'],
      date: json['date'],
      status: json['status'],
      items: List<dynamic>.from(json['items']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quotationBy': quotationBy,
      'date': date,
      'status': status,
      'items': items,
    };
  }
}
