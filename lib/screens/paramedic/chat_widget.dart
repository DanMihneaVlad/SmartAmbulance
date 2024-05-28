import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/providers/chat_provider.dart';
import 'package:smart_ambulance/screens/chat/chat_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_user_chat_tile.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ParamedicChatWidgetState();
}

class _ParamedicChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    var chatProvider = context.watch<ChatProvider>();

    return FutureBuilder(
      future: Future.wait([
        chatProvider.getUsersToChat
      ]), 
      builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          if (asyncSnapshot.hasError) {
            return Text(AppLocalizations.of(context)!.chat_loading_error,
              style: SmartAmbulanceTextStyles.errorTextStyle,
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: chatProvider.usersToChat.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return CustomUserChatTile(
                    user: chatProvider.usersToChat[index], 
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: context.read<ChatProvider>(),
                          child: ChatScreen(user: chatProvider.usersToChat[index],),
                        )
                      ));
                    }
                  );
                }
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}