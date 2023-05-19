import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/chat_gpt_model/chatmessage.dart';
import 'package:provider/provider.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget({
    Key? key,
    required this.text,
    required this.chatMessageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        mainAxisAlignment: chatMessageType == ChatMessageType.user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (chatMessageType == ChatMessageType.bot)
            ProfileContainer(chatMessageType: chatMessageType),
          if (chatMessageType == ChatMessageType.bot) const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6),
            decoration: BoxDecoration(
              color: chatMessageType == ChatMessageType.user
                  ? Colors.blue
                  : Colors.grey.shade700,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: chatMessageType == ChatMessageType.user
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
                bottomRight: chatMessageType == ChatMessageType.user
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          if (chatMessageType == ChatMessageType.user)
            const SizedBox(width: 15),
          if (chatMessageType == ChatMessageType.user)
            ProfileContainer(chatMessageType: chatMessageType),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.chatMessageType,
  });

  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userAuth = authProvider.userLoggedIn;
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: chatMessageType == ChatMessageType.user
            ? Colors.white
            : Colors.grey.shade700,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: chatMessageType == ChatMessageType.user
              ? const Radius.circular(0)
              : const Radius.circular(15),
          bottomRight: chatMessageType == ChatMessageType.user
              ? const Radius.circular(15)
              : const Radius.circular(0),
        ),
      ),
      child: chatMessageType == ChatMessageType.user
          ? SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: CachedNetworkImage(
                      imageUrl: userAuth.avatar,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )),
            )
          : Image.asset(
              "assets/images/chatbot.png",
              scale: 1.5,
            ),
    );
  }
}
