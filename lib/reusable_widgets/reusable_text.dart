import 'package:flutter/cupertino.dart';

import '../utils/text_styles.dart';

class ReusableText extends StatelessWidget {
  final String count;
  final String status;
  const ReusableText({
    super.key, required this.count, required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyles.mediumText,
        ),
        Text(
          status,
          style: TextStyles.textButton2,
        ),
      ],
    );
  }
}