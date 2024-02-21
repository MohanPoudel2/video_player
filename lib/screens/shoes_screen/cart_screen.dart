import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_player_app/utils/text_styles.dart';

import '../../provider/shoes_list_provider/shoes_list_provider.dart';
import '../../utils/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<NewShoesListProvider>();
    final cartItems = cartProvider.cartItems;
    final totalSum =
        cartItems.fold(0, (sum, shoe) => sum + int.parse("${shoe.price}"));
    int charge = 10;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
          decoration:  const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg3.jpg'), fit: BoxFit.fill)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Add more',
                        style: TextStyles.smallText.copyWith(color: Colors.red),
                      ))
                ],
              ),
           
              if (cartItems.isEmpty)
                 const Expanded(
                  child:Center(
                    child: Text('Nothing to show here',style: TextStyles.tabText2,),
                  )
                ),
              if (cartItems.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final selectedCart = cartItems[index];
                    int count=cartItems[index].quantity;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Card(
                            elevation: 4,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              AssetImage(selectedCart.image))),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedCart.name,
                                        style: TextStyles.smallText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        '\$${selectedCart.price} * ${selectedCart.quantity} = ${selectedCart.price * selectedCart.quantity}',
                                        style: TextStyles.smallText,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                         setState(() {
                                           if (count > 1) {
                                           cartProvider.addToCart(selectedCart, -1);
                                           }


                                         });
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 16,
                                        )),
                                    Text(
                                      '$count',
                                      style: TextStyles.tabText2
                                          .copyWith(fontSize: 14),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cartProvider.addToCart(selectedCart, 1);

                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 16,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            right:-1,
                            top: -30,
                            child: InkWell(
                              onTap:(){
                                      context
                                          .read<NewShoesListProvider>()
                                          .removeFromCart(selectedCart);
                              },
                              child: Container(
                                width: 25,
                                height: 80,
                                decoration:  const BoxDecoration(
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius:-3,
                                    blurRadius:10,
                                    offset: Offset(1, 10),

                                  ),
                                ],
                                    shape: BoxShape.circle,
                                  
                                  color:AppColors.bottomNev,
                                  image: DecorationImage(
                                    image: AssetImage('assets/cross.png'),

                                  )

                                ),
                              ),
                            )),
                      ],
                    );
                  },
                )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total :',
                    style: TextStyles.tabText2,
                  ),
                  Text(
                      '${cartProvider.getTotalPrice()}',
                    style: TextStyles.tabText2,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  final cartProvider = context.read<NewShoesListProvider>();
                  cartProvider.checkoutAndMoveToHistory();
                  if (cartItems.isNotEmpty) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return GiffyDialog.image(
                          Image.network(
                            "https://media1.giphy.com/media/W2oYmaE8euR7gfx4Ke/200.webp?cid=790b7611n2zl0t1ectba2q3x919mojv4ctuj2c1psba9rzeb&ep=v1_gifs_search&rid=200.webp&ct=g",
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          content: const Text(
                            'Congratulations! Your order has been successfully placed. Thank you for choosing our service!',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return GiffyDialog.image(
                          Image.network(
                            "https://media0.giphy.com/media/ISOckXUybVfQ4/200.webp?cid=790b7611y86hgui1flcw1njakl9ptp79h0sgm6y0hl7j3oq8&ep=v1_gifs_search&rid=200.webp&ct=g",
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          content: const Text(
                            'Oops! It looks like you haven’t selected any items yet. Please add products to your cart before proceeding to checkout. Happy shopping!',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top:20, bottom: 20),
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.iconColor),
                  child: const Center(
                    child: Text('Check Out'),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  // void _onIncrement() {
  //   setState(() {
  //     _count++;
  //   });
  // }
  //
  // void _onDecrement() {
  //   setState(() {
  //     if (_count > 1) {
  //       _count--;
  //     }
  //   });
  // }
}
