


import 'package:flutter/cupertino.dart';

class ReusableColorContainer extends StatelessWidget {
  final Color color;
  const ReusableColorContainer({
    super.key, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:20,
      height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color
      ),
    );
  }
}