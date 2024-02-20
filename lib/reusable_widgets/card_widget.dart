
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class CardWidget extends StatelessWidget {
  final String name,image;
  const CardWidget({
    super.key, required this.name, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
          const BorderSide(color: Colors.transparent)),
      child: Container(
          height: 150,
          width: 200,
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child:Column(


            children: [
              Image.asset(image,width: 80,height: 80,),
              Text(name,style: TextStyles.mediumTextStyle,)
            ],
          )
      ),
    );
  }
}
