import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/models/user/user_model.dart';

class CustomUserChatTile extends StatefulWidget {
  const CustomUserChatTile({required this.user, required this.onTap, super.key});

  final UserModel user;
  final void Function()? onTap;

  @override
  State<CustomUserChatTile> createState() => _CustomUserChatTileState();
}

class _CustomUserChatTileState extends State<CustomUserChatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.tileHorizontalPadding, vertical: SmartAmbulanceSizes.tileVerticalPadding),
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(SmartAmbulanceSizes.borderRadius)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 194, 194, 194),
                spreadRadius: 1.5,
                blurRadius: 5
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: SmartAmbulanceSizes.mediumSizedBox,),
                const Icon(Icons.person),
                const SizedBox(width: SmartAmbulanceSizes.mediumSizedBox,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.user.firstName} ${widget.user.lastName}',
                      style: SmartAmbulanceTextStyles.userTileTextStyle,
                    ),
                    Text(
                      widget.user.email,
                      style: SmartAmbulanceTextStyles.userTileTextStyle,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}