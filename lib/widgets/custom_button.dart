import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';

class SmartAmbulanceButton extends StatelessWidget {
  const SmartAmbulanceButton({super.key, required this.text, this.onPressed, this.height, required this.fontSize});

  final String text;
  final void Function()? onPressed;
  final double? height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SmartAmbulanceSizes.borderRadius)
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: height,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}