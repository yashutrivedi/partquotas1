import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partquotes_admin/models/shopping_cart.dart';
import 'package:partquotes_admin/screens/quotation_detail.dart';

class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotations'),
      ),
      body: QuotationList(),
    );
  }
}

class QuotationList extends StatelessWidget {
  Future<void> _updateQuotationStatus(String quotationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('quotations')
          .doc(quotationId)
          .update({
        'status': true, // Assuming the field name in Firestore is 'status'
      });
      print('Quotation status updated successfully');
    } catch (e) {
      print('Error updating quotation status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('quotations').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No quotations found'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            var list = ShoppingItem.convertMapListToItems(document['items']);
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuotationDetailPage(quotationStatusItem: list),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(document['quotationBy']),
                  subtitle: Text(document['date'].toString().substring(0, 10)),
                  trailing: document['status'] == false
                      ? IconButton(
                          onPressed: () =>
                              {_updateQuotationStatus(document.id)},
                          icon: Icon(Icons.check))
                      : null,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
