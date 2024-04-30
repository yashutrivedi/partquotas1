class ShoppingItem {
  String name;
  int quantity;
  double price;
  String? image;

  ShoppingItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }

  static ShoppingItem fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      image: map['image'],
    );
  }

  static List<Map<String, dynamic>> convertItemsToMapList(
      List<ShoppingItem> items) {
    List<Map<String, dynamic>> mapList = [];
    for (var item in items) {
      mapList.add(item.toMap());
    }
    return mapList;
  }

  static List<ShoppingItem> convertMapListToItems(dynamic mapList) {
    List<ShoppingItem> items = [];
    for (var map in mapList) {
      items.add(ShoppingItem.fromMap(map));
    }
    return items;
  }
}
