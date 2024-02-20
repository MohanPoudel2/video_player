import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class ReUsableCard extends StatelessWidget {
  final String amount;
  const ReUsableCard({
    super.key, required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),

      ),
      child: Container(
          padding: const EdgeInsets.all(5),
          child:  Text(amount,style: TextStyles.tabText1,)),
    );
  }
}