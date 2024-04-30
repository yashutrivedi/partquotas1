import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  final String? itemId;
  final String? initialTitle;
  final String? initialPrice;
  final String? initialDescription;
  final String? initialModel;
  final Uint8List? initialImage;

  const AddItem({
    Key? key,
    this.itemId,
    this.initialTitle,
    this.initialPrice,
    this.initialDescription,
    this.initialModel,
    this.initialImage,
  }) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _modelController;
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _priceController = TextEditingController(text: widget.initialPrice ?? '');
    _descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
    _modelController = TextEditingController(text: widget.initialModel ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemId != null ? 'Edit Item' : 'Add Item'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select Image'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('From Gallery'),
                            onTap: () {
                              _getImage(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Take a Picture'),
                            onTap: () {
                              _getImage(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : widget.initialImage != null
                        ? Image.memory(
                            widget.initialImage!,
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Icon(Icons.add_photo_alternate, size: 40.0),
                          ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Applicable Model'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var imagedata = null;
                    if (_image != null) {
                      var unitList = await _image!.readAsBytes();
                      imagedata = base64Encode(unitList);
                    }

                    if (widget.itemId != null) {
                      // Update item
                      FirebaseFirestore.instance
                          .collection('products')
                          .doc(widget.itemId)
                          .update({
                        'title': _titleController.text.trim(),
                        'price': _priceController.text.trim(),
                        'image': imagedata.toString(),
                        'description': _descriptionController.text.trim(),
                        'applicablemodel': _modelController.text.trim(),
                        // Update other fields if needed
                      }).then((_) {
                        Navigator.pop(context);
                      }).catchError((error) {
                        print("Failed to update item: $error");
                      });
                    } else {
                      // Add new item
                      FirebaseFirestore.instance.collection('products').add({
                        'title': _titleController.text.trim(),
                        'price': _priceController.text.trim(),
                        'image': imagedata.toString(),
                        'description': _descriptionController.text.trim(),
                        'applicablemodel': _modelController.text.trim(),
                        // Add other fields if needed
                      }).then((_) {
                        Navigator.pop(context);
                      }).catchError((error) {
                        print("Failed to add item: $error");
                      });
                    }
                  },
                  child: Text(widget.itemId != null ? 'Update' : 'Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
