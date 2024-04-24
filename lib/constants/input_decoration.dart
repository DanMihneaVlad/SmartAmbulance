import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';

class SmartAmbulanceDecoration {
  static InputDecoration inputDecoration({required String hintText}) { 
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(SmartAmbulanceSizes.borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(SmartAmbulanceSizes.borderRadius),
      ),
      fillColor: Colors.grey[250],
      filled: true,
      hintText: hintText
    );
  }
}