import 'package:flutter/material.dart';
import 'package:notification/config/themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.lable, this.onTap});
  final String lable;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 40,
       
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
        child: Center(
            child: Text(
          lable,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
