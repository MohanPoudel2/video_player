class NewShoesListModel {
  final String name;
  final String image;
  final int price;
  late final int quantity;

  NewShoesListModel(
      {required this.name,
      required this.image,
      required this.price,
      required this.quantity});

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'price': price, 'quantity': quantity};
  }

  factory NewShoesListModel.fromJson(Map<String, dynamic> jsonData) {
    return NewShoesListModel(
        name: jsonData['name'],
        image: jsonData['image'],
        price: jsonData['price'],
        quantity: jsonData['quantity']);
  }

  NewShoesListModel copyWith({
    String? name,
    String? image,
    int? price,
    int? quantity,
  }) {
    return NewShoesListModel(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
