

import 'package:flutter/material.dart';

import '../models/new_shoes_list.dart';
import '../utils/text_styles.dart';

class MyCard extends StatefulWidget {
  final NewShoesListModel historyList;

  const MyCard({super.key, required this.historyList});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final historyList = widget.historyList;
    return Column(
      children: [
        Card(
          elevation: 0,
          shape: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(20),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        // bottomLeft: Radius.circular(
                        //   30,
                        // ),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(historyList.image),
                    )),
              ),
              Text(
                '${widget.historyList.name}\n',
                style: TextStyles.smallText,
              ),
              IconButton(
                  onPressed: () {
                    _onTapped();
                  },
                  icon: Icon(
                      tapped ? Icons.expand_more_outlined : Icons.expand_less)),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        tapped
            ? Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.lightBlue.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name : ',
                    style: TextStyles.smallText,
                  ),
                  Text(
                    historyList.name,
                    style: TextStyles.smallText,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Price of one item : ',
                    style: TextStyles.smallText,
                  ),
                  Text(
                    '\$${historyList.price}',
                    style: TextStyles.smallText,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quantity : ',
                    style: TextStyles.smallText,
                  ),
                  Text(
                    '${historyList.quantity}',
                    style: TextStyles.smallText,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Price : ',
                    style: TextStyles.smallText,
                  ),
                  Text(
                    '\$${historyList.price * historyList.quantity}',
                    style: TextStyles.smallText,
                  )
                ],
              ),
            ],
          ),
        )
            : Container()
        // Show or hide the text based on the tapped state
      ],
    );
  }

  void _onTapped() {
    setState(() {
      tapped = !tapped;
    });
  }
}