import 'package:flutter/material.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/text_styles.dart';

class AddHospital extends StatefulWidget {
  const AddHospital({super.key});

  @override
  State<AddHospital> createState() => _AddHospital();
}

class _AddHospital extends State<AddHospital> {
  final _hospitalNameController = TextEditingController();
  final _hospitalAddressController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: CustomAppBar(title: "Add Hospital", backButton: false, signOutButton: true),
     body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                
                const Icon(
                  Icons.local_hospital_rounded,
                  size: 100,
                  color: Colors.red,
                ),
                const SizedBox(height: 50),
          
                Text(
                  "Add Hospital",
                  style: SmartAmbulanceTextStyles.appTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SmartAmbulanceSizes.bigSizedBox),
          
                // Email textfield
                TextField(
                  controller: _hospitalNameController,
                  keyboardType: TextInputType.text,
                  decoration: SmartAmbulanceDecoration.inputDecoration(hintText: "Name")
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),

                // Password textfield
                TextField(
                  controller: _hospitalAddressController,
                  obscureText: true,
                  decoration: SmartAmbulanceDecoration.inputDecoration(hintText: "Address")
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
          
                SmartAmbulanceButton(text: "Add", fontSize: SmartAmbulanceSizes.bigButtonFontSize, onPressed: (() async {
                
                }),),]))))
      );
  }
}