import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:partquote_client/Screens/statumodel.dart';
import 'package:partquote_client/model/cartmodel.dart';

class QuotationDetailPage extends StatelessWidget {
  final List<ShoppingItem> quotationStatusItem;

  const QuotationDetailPage({Key? key, required this.quotationStatusItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quotation Details'),
        ),
        body: ListView.builder(
            itemCount: quotationStatusItem.length,
            itemBuilder: (context, index) {
              Uint8List? bytes;
              if (quotationStatusItem[index].image != null) {
                bytes = base64Decode(quotationStatusItem[index].image!);
              }
              return ListTile(
                  leading: Container(
                    child: bytes != null
                        ? Image.memory(bytes!)
                        : Icon(Icons.image),
                  ),
                  title: Text(quotationStatusItem[index].name),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "qty ${quotationStatusItem[index].quantity.toString()}",
                      ),
                      Text(
                        "price ${quotationStatusItem[index].price.toString()}",
                      ),
                      Text(
                        "Total ${quotationStatusItem[index].price * quotationStatusItem[index].quantity}",
                      ),
                    ],
                  ));
            }));
  }
}
