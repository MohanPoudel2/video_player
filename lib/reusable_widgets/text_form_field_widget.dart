

import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            hintText: '  search.....',
            suffixIcon: const Icon(Icons.search),
            hintStyle:
            TextStyles.tabText1.copyWith(color: Colors.black12)),
      ),
    );
  }
}