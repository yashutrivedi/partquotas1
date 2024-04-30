import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:partquotes_admin/models/shopping_cart.dart';
import 'firebase_services.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quotationStatusItem.length,
              itemBuilder: (context, index) {
                return QuotationListItem(
                  item: quotationStatusItem[index],
                  index: index,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Save quotation details when button is pressed
                _saveQuotationDetails();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // background color
                onPrimary: Colors.white, // text color
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(150, 50), // Set width and height
              ),
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _saveQuotationDetails() {
    // You can implement saving logic here
    // For example, call FirebaseServices.saveQuotationDetails
  }
}

class QuotationListItem extends StatefulWidget {
  final ShoppingItem item;
  final int index;

  const QuotationListItem({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  _QuotationListItemState createState() => _QuotationListItemState();
}

class _QuotationListItemState extends State<QuotationListItem> {
  bool isChecked = false;
  late TextEditingController _totalController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the initial total value
    _totalController = TextEditingController(
      text: (widget.item.price * widget.item.quantity).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    if (widget.item.image != null) {
      bytes = base64Decode(widget.item.image!);
    }

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
                // Update Firestore when checkbox state changes
                FirebaseServices.updateCheckboxValue(
                    widget.index.toString(), isChecked);
              });
            },
          ),
          Container(
            child: bytes != null ? Image.memory(bytes) : Icon(Icons.image),
          ),
        ],
      ),
      title: Text(widget.item.name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("qty ${widget.item.quantity.toString()}"),
          Text("price ${widget.item.price.toString()}"),
          Text(
            "Total",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 100,
            child: TextField(
              controller: _totalController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Update the total when the value changes
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _totalController.dispose();
    super.dispose();
  }
}
