import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomImageBottomSheet extends StatefulWidget {
  const CustomImageBottomSheet({super.key, required this.onPressed, required this.text});

  final void Function(ImageSource) onPressed;
  final String text;

  @override
  State<CustomImageBottomSheet> createState() => _CustomImageBottomSheetState();
}

class _CustomImageBottomSheetState extends State<CustomImageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text(
          widget.text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: Text(AppLocalizations.of(context)!.add_patient_picture_camera),
              icon: const Icon(Icons.camera),
              onPressed: (() {
                widget.onPressed(ImageSource.camera);
              }),
            ),
            TextButton.icon(
              label: Text(AppLocalizations.of(context)!.add_patient_picture_gallery),
              icon: const Icon(Icons.image),
              onPressed: (() {
                widget.onPressed(ImageSource.gallery);
              }),
            ),
          ],
        )
      ]),
    );
  }
}