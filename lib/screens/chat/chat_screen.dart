import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/models/message/message_model.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/providers/chat_provider.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.user, super.key});

  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _messageController = TextEditingController();

  late final ChatProvider chatProvider;

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    chatProvider = context.read<ChatProvider>();

    myFocusNode.addListener(() { 
      if (myFocusNode.hasFocus) {
        // delay for keyboard to show up. Scroll down
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    // scroll to the bottom of the messages
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.user.email, backButton: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding / 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: SmartAmbulanceSizes.verticalPadding),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: chatProvider.getMessages(widget.user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(textAlign: TextAlign.center, style: SmartAmbulanceTextStyles.errorTextStyle, AppLocalizations.of(context)!.loading_error));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Text(textAlign: TextAlign.center, style: SmartAmbulanceTextStyles.appTitleTextStyle, AppLocalizations.of(context)!.loading_waiting));
                      }

                      return ListView(
                        controller: _scrollController,
                        children: snapshot.data!.docs.map((msg) => createMsgCard(msg)).toList(),
                      );
                    }
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: myFocusNode,
                        controller: _messageController,
                        decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.chat_enter_message),
                        minLines: 1,
                        maxLines: 2,
                      ),
                    ),

                    IconButton(
                      onPressed: sendMessage, 
                      icon: const Icon(Icons.send, color: Colors.green,)
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await chatProvider.sendMessage(widget.user.uid, widget.user.email, _messageController.text.trim());

      _messageController.clear();

      scrollDown();
    }
  }

  Widget createMsgCard(DocumentSnapshot msg) {
    MessageModel message = MessageModel.fromJson(msg.data() as Map<String, dynamic>);

    bool isCurrentUser = message.senderUid == chatProvider.userService.userId;

    return CustomChatBubble(isCurrentUser: isCurrentUser, message: message.message);
  }
}