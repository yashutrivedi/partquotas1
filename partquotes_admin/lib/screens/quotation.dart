import 'package:flutter/material.dart';
import 'package:partquotes_admin/models/quotation_request_listmodel.dart';

class QuotationList extends StatelessWidget {
  final List<Quotation> quotations = [
    Quotation(
      number: 'Q001',
      date: DateTime.now(),
      customerName: 'yashvi trivedi',
      customerMobile: '1234567890',
      itemCount: 3,
      quantity: 5,
      price: 100.0,
    ),
    Quotation(
      number: 'Q002',
      date: DateTime.now(),
      customerName: 'mital manjusra',
      customerMobile: '9876543210',
      itemCount: 2,
      quantity: 10,
      price: 200.0,
    ),
    // Add more quotations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotation List'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: quotations.length,
                itemBuilder: (context, index) {
                  final quotation = quotations[index];
                  return Card(
                    child: ListTile(
                      title: Text('Quotation Number: ${quotation.number}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${quotation.date.toString()}'),
                          Text('Customer name: ${quotation.customerName}'),
                          Text('Customer Mobile: ${quotation.customerMobile}'),
                          Text('Item Count: ${quotation.itemCount}'),
                          Text('Quantity: ${quotation.quantity}'),
                          Text('Price: ${quotation.price}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
