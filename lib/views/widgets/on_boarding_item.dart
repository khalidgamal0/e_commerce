
import 'package:flutter/material.dart';
import 'package:shop_app/models/on_boarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.boardingItem,
  });
  final OnBoardingModel boardingItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            boardingItem.image,
          ),
        ),
        Text(
          boardingItem.text,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold

              , fontSize: 32),
        ),
        const SizedBox(height: 10,),
        Text(
          boardingItem.subText,
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}