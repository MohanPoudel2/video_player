import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/models/new_shoes_list.dart';
import 'package:video_player_app/screens/shoes_screen/shoe_detail_ui.dart';

import '../provider/shoes_list_provider/shoes_list_provider.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class NewShoesWidget extends StatelessWidget {
  const NewShoesWidget({
    super.key,
    required this.shoesListNotifier,
  });

  final NewShoesListProvider shoesListNotifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: shoesListNotifier.shoesList.length,
        itemBuilder: (context, index) {
          final selectedCart = shoesListNotifier.shoesList[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) => ShoeDetailsUi(newShoesListModel: selectedCart), ));
            },
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                            shoesListNotifier.shoesList[index].image,
                          ),
                          fit: BoxFit.fill)),
                  child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added to cart!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        // context
                        //     .read<NewShoesListProvider>()
                        //     .addToCart(selectedCart,1);
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.bottomNev,
                        size: 30,
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 130,
                  child: Column(
                    children: [
                      Text(
                        shoesListNotifier.shoesList[index].name,
                        style: TextStyles.smallText,
                      ),
                      Text(
                        '\$${shoesListNotifier.shoesList[index].price}',
                        style: TextStyles.smallText,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(left: 10));
        },
      ),
    );
  }
}
