import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/new_shoes_list.dart';
import '../../models/running_shoes_list.dart';

class NewShoesListProvider with ChangeNotifier {
  late NewShoesListModel _selectedShoes;
  late RunningShoesListModel _selectedRunningShoes;
  final List<NewShoesListModel> _shoesList = [
    NewShoesListModel(name: 'Sneaker', image: 'assets/sneaker1.jpg', price: 85, quantity: 1, id: 1, ),
    NewShoesListModel(
        name: 'Sneaker', image: 'assets/sneaker2.jpg', price: 100, quantity: 1, id: 2),
    NewShoesListModel(name: 'Sneaker', image: 'assets/sneaker3.jpg', price: 77, quantity: 1, id: 3, ),
    NewShoesListModel(
        name: 'Sneaker', image: 'assets/sheaker4.jpg', price: 120, quantity: 1, id: 4, ),
  ];

  List<NewShoesListModel> get shoesList => _shoesList;
  //for new shoes



  final List<RunningShoesListModel> _runningList = [
    RunningShoesListModel(
        name: 'Sneaker', image: 'assets/sneaker5.jpg', price: 85.00),
    RunningShoesListModel(
        name: 'Sneaker', image: 'assets/sneaker6.jpg', price: 100),
    RunningShoesListModel(
        name: 'Sneaker', image: 'assets/sneaker7.jpg', price: 77.5),
    RunningShoesListModel(
        name: 'Sneaker', image: 'assets/sneaker8.jpg', price: 120),
  ];

    List<RunningShoesListModel> get runList => _runningList;
//for running type shoes


  final List<NewShoesListModel> _cartItems = [];

  List<NewShoesListModel> get cartItems => _cartItems;

  void addToCart(NewShoesListModel product,int count) {
    int index=_cartItems.indexWhere((item) => item.id==product.id);
    if(index!=-1){
      _cartItems[index].quantity+=count;
    }else{
      _cartItems.add(product.copyWith(quantity: count));
    }
    notifyListeners();
  }
  double getTotalPrice() {
    double total = 0.0;
    // loop over the cart items
    for (var item in _cartItems) {
      // add the product of price and quantity to the total
      total += item.price * item.quantity;
    }
    // return the total
    return total;
  }

  void removeFromCart(NewShoesListModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }
//for adding to cart and removing

  final List<NewShoesListModel> _historyCart = [];

  List<NewShoesListModel> get historyCartList => _historyCart;

  void checkoutAndMoveToHistory() async{
    final cartItems = List<NewShoesListModel>.from(_cartItems);

    for (var item in cartItems) {
      _historyCart.add(item);
    }
    await saveHistory(cartItems);
    notifyListeners();
  }
  double getTotalForHistory() {
    double total = 0.0;
    // loop over the cart items
    for (var item in _historyCart) {
      // add the product of price and quantity to the total
      total += item.price * item.quantity;
    }
    // return the total
    return total;
  }
  Future<void> saveHistory(List<NewShoesListModel> history) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _historyCart.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('history_key', encodedData);
  }

  Future<void> loadHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? historyString = prefs.getString('history_key');
    final List<dynamic> historyData = json.decode(historyString!);
    _historyCart.clear();
    _historyCart.addAll(historyData.map((item) => NewShoesListModel.fromJson(item)));
    notifyListeners();
  }
  //for showing history form cart screen and storing data in local storage


}
