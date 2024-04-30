import 'package:flutter/material.dart';

class QuotationStatusItem {
  final String quotationNumber;
  final DateTime date;
  final String itemName;
  final int quantity;
  final double price;

  QuotationStatusItem({
    required this.quotationNumber,
    required this.date,
    required this.itemName,
    required this.quantity,
    required this.price,
  });
}
