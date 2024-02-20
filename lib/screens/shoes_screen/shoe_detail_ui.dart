import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/models/new_shoes_list.dart';
import '../../provider/shoes_list_provider/shoes_list_provider.dart';
import '../../reusable_widgets/reusable_card.dart';
import '../../reusable_widgets/reusable_color_container.dart';
import '../../reusable_widgets/reusable_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';

class ShoeDetailsUi extends StatefulWidget {
  final NewShoesListModel newShoesListModel;

  const ShoeDetailsUi({
    super.key,
    required this.newShoesListModel,
  });

  @override
  State<ShoeDetailsUi> createState() => _ShoeDetailsUiState();
}

class _ShoeDetailsUiState extends State<ShoeDetailsUi> {
  bool isPressed = false;
  int _count = 1;

  void pressed() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomNev,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Card(
            elevation: 2,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            child: IconButton(
              onPressed: () {
                pressed();
              },
              icon: Icon(
                isPressed == false ? Icons.favorite_border : Icons.favorite,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                          image: DecorationImage(
                              image: AssetImage(widget.newShoesListModel.image),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.newShoesListModel.name,
                              style: TextStyles.mediumText,
                            ),
                            Text(
                              '\$${widget.newShoesListModel.price}',
                              style: TextStyles.mediumText,
                            ),
                          ],
                        )),
                    const Positioned(
                        left: 20,
                        bottom: 100,
                        child: Row(
                          children: [
                            ReusableText(
                              count: '190',
                              status: 'Sold',
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            ReusableText(
                              count: '2586',
                              status: 'Views',
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            ReusableText(
                              count: '190',
                              status: 'Favourites',
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 10,
                      left: 20,
                      child: Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SIZE',
                                style: TextStyles.tabText1,
                              ),
                              Row(
                                children: [
                                  ReUsableCard(
                                    amount: '7',
                                  ),
                                  ReUsableCard(
                                    amount: '7.5',
                                  ),
                                  ReUsableCard(
                                    amount: '8',
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _onDecrement();
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text(
                                '$_count',
                                style: TextStyles.tabText2,
                              ),
                              IconButton(
                                  onPressed: () {
                                    _onIncrement();
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            children: [
                              Text(
                                'COLOR',
                                style: TextStyles.tabText1,
                              ),
                              Row(
                                children: [
                                  ReusableColorContainer(
                                    color: Colors.pink,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  ReusableColorContainer(
                                    color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  ReusableColorContainer(
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  ReusableColorContainer(
                                    color: Colors.orange,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item added to cart!'),
                  duration: Duration(seconds: 2),
                ),
              );

              context
                  .read<NewShoesListProvider>()
                  .addToCart(widget.newShoesListModel,_count);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 60, bottom: 20),
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text('ADD TO CART'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onIncrement() {
    setState(() {
      _count++;
    });
  }

  void _onDecrement() {
    setState(() {
      if (_count > 1) {
        _count--;
      }
    });
  }
}
