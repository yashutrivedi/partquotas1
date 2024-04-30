import 'dart:convert'; // Required for base64 decoding
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'add_item.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search functionality here
              // You can use _searchQuery variable to get the search query
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                // Filter documents based on search query
                List<DocumentSnapshot> filteredDocuments = _searchQuery.isEmpty
                    ? documents
                    : documents.where((document) {
                        String title =
                            document['title'].toString().toLowerCase();
                        return title.contains(_searchQuery.toLowerCase());
                      }).toList();

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      // Adjusted aspect ratio to display full image
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        filteredDocuments[index].data() as Map<String, dynamic>;
                    String title = data['title'] ?? 'No Title';
                    String price = data['price'] ?? 'Unknown';
                    String description =
                        data['description'] ?? 'No Description';
                    String applicableModel =
                        data['applicablemodel'] ?? 'No Applicable Model';
                    String imageBase64 = data['image'] ?? '';

                    // Decode base64 string to image
                    Uint8List? bytes;
                    if (imageBase64.isNotEmpty) {
                      bytes = base64Decode(imageBase64);
                    }

                    return GestureDetector(
                      onTap: () {
                        // Show full image on tap if needed
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              height: mq.height * 0.18,
                              width: mq.width * 0.4,
                              child: bytes != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        bytes,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Icon(Icons.image),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    '₹ $price',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    '$description',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => AddItem(
                                              itemId:
                                                  filteredDocuments[index].id,
                                              initialTitle: title,
                                              initialPrice: price,
                                              initialDescription: description,
                                              initialModel: applicableModel,
                                              initialImage:
                                                  bytes, // Pass the image data
                                            )),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Handle delete action
                                    FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(filteredDocuments[index].id)
                                        .delete();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => AddItem())),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
