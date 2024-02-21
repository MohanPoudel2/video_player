class NewShoesListModel {
  final int id;
  final String name;
  final String image;
  final int price;
    int quantity;

  NewShoesListModel(
      {required this.id,
        required this.name,
      required this.image,
      required this.price,
       required this.quantity});

  Map<String, dynamic> toJson() {
    return {'id':id,'name': name, 'image': image, 'price': price, 'quantity': quantity};
  }

  factory NewShoesListModel.fromJson(Map<String, dynamic> jsonData) {
    return NewShoesListModel(
      id:jsonData['id'],
        name: jsonData['name'],
        image: jsonData['image'],
        price: jsonData['price'],
        quantity: jsonData['quantity']);
  }

  NewShoesListModel copyWith({
    int? id,
    String? name,
    String? image,
    int? price,
    int? quantity,
  }) {
    return NewShoesListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
