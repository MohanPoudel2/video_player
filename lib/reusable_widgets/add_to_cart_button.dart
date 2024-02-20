import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/shoes_list_provider/shoes_list_provider.dart';
import '../screens/shoes_screen/shoe_detail_ui.dart';
import '../utils/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.widget,
  });

  final ShoeDetailsUi widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added to cart!'),
            duration: Duration(seconds: 2),
          ),
        );

        // context
        //     .read<NewShoesListProvider>()
        //     .addToCart(widget.newShoesListModel);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 60,bottom:20),
        height: 60,
        width: 300,
        decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(16)),
        child: const Center(
          child: Text('ADD TO CART'),
        ),
      ),
    );
  }
}