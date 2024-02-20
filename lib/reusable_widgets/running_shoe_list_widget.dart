import 'package:flutter/material.dart';


import '../provider/shoes_list_provider/shoes_list_provider.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class RunningShoesWidget extends StatelessWidget {
  const RunningShoesWidget({
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
        itemCount: shoesListNotifier.runList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(
                          shoesListNotifier.runList[index].image,
                        ),
                        fit: BoxFit.fill)),
                child: IconButton(
                    onPressed: () {},
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
                      shoesListNotifier.runList[index].name,
                      style: TextStyles.smallText,
                    ),
                    Text(
                      '\$${shoesListNotifier.runList[index].price}',
                      style: TextStyles.smallText,
                    )
                  ],
                ),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.only(left: 10));
        },
      ),
    );
  }
}