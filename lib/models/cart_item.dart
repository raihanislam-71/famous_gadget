class CartItem {
  const CartItem({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.imagePath,
  });

  final String id;
  final String name;
  final double unitPrice;
  final int quantity;
  final String imagePath;

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      unitPrice: unitPrice,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath,
    );
  }

  Map<String, Object> toJson() => {
    'id': id,
    'name': name,
    'unitPrice': unitPrice,
    'quantity': quantity,
    'imagePath': imagePath,
  };

  factory CartItem.fromJson(Object? value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Cart item must be an object.');
    }

    final id = value['id'];
    final name = value['name'];
    final unitPrice = value['unitPrice'];
    final quantity = value['quantity'];
    final imagePath = value['imagePath'];
    if (id is! String ||
        name is! String ||
        unitPrice is! num ||
        quantity is! int ||
        imagePath is! String ||
        quantity < 1) {
      throw const FormatException('Cart item contains invalid data.');
    }

    return CartItem(
      id: id,
      name: name,
      unitPrice: unitPrice.toDouble(),
      quantity: quantity,
      imagePath: imagePath,
    );
  }
}
