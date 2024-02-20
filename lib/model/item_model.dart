class Item {
  final String itemName;
  final String quantity;
  final String price;
  final String expiryDate;
  final String barcode;

  Item({
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.expiryDate,
    required this.barcode,
  });

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        itemName: json['itemName'],
        quantity: json['quantity'],
        price: json['price'],
        expiryDate: json['expiryDate'],
        barcode: json['barcode'],
      );

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'quantity': quantity,
        'price': price,
        'expiryDate': expiryDate,
        'barcode': barcode,
      };
}
