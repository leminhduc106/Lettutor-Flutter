import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_flutter/cubit/chat/chat_cubit.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/chat_gpt_model/chatmessage.dart';
import 'package:lettutor_flutter/models/language_model/language.dart';
import 'package:lettutor_flutter/services/chat_gpt_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/chat_message/chat_message.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ChatGPTAssistantPage extends StatefulWidget {
  const ChatGPTAssistantPage({Key? key}) : super(key: key);

  @override
  State<ChatGPTAssistantPage> createState() => _ChatGPTAssistantPageState();
}

class _ChatGPTAssistantPageState extends State<ChatGPTAssistantPage> {
  var isListening = false;
  var text = 'Hold the button to speak';
  SpeechToText speechToText = SpeechToText();
  final _scrollController = ScrollController();
  late bool isLoading;
  late FocusNode _focusNode;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              lang.chatAssistant,
              style: BaseTextStyle.heading2(
                  fontSize: 20, color: BaseColor.secondaryBlue),
            ),
          ),
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    child: _buildListMessage(),
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 190, vertical: 16),
                    child: const CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      _buildTextField(lang),
                      _buildSendButton(lang),
                    ],
                  ),
                ),
                AvatarGlow(
                  endRadius: 35,
                  animate: isListening,
                  duration: const Duration(milliseconds: 2000),
                  glowColor: const Color(0xff00A67E),
                  repeat: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  showTwoGlows: true,
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTapDown: (details) async {
                          if (!isListening) {
                            var available = await speechToText.initialize();
                            if (available) {
                              setState(() {
                                isListening = true;
                              });
                              speechToText.listen(
                                onResult: (result) {
                                  setState(() {
                                    text = result.recognizedWords;
                                    _textController.text = text;
                                  });
                                },
                              );
                            }
                          }
                        },
                        onTapUp: (details) async {
                          setState(() {
                            isListening = false;
                          });
                          await speechToText.stop();
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff00A67E),
                          radius: 25,
                          child: Icon(
                            isListening ? Icons.mic : Icons.mic_none,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  lang.holdToSpeak,
                  style: TextStyle(
                    fontSize: 12,
                    color: isListening ? Colors.black54 : Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(Language lang) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          focusNode: _focusNode,
          textCapitalization: TextCapitalization.sentences,
          controller: _textController,
          style: const TextStyle(color: Colors.black54),
          decoration: InputDecoration(
            hintText: lang.chatOrTalk,
            hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton(Language lang) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Visibility(
          visible: !isLoading,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color(0xff00A67E),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.send),
              iconSize: 25,
              color: Colors.white,
              onPressed: () {
                //display user input
                if (_textController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(lang.errorEmptyMessage),
                    backgroundColor: Colors.grey,
                  ));
                  return;
                }
                setState(() {
                  context.read<ChatCubit>().addMessage(ChatMessage(
                      text: _textController.text,
                      chatMessageType: ChatMessageType.user));
                  isLoading = true;
                });
                var input = _textController.text;
                _textController.clear();
                _focusNode.unfocus();
                Future.delayed(const Duration(milliseconds: 50))
                    .then((value) => _scrollDown());

                // call chatbot api
                ChatGptService.generateResponse(input).then((value) {
                  setState(() {
                    isLoading = false;
                    //display chatbot response
                    context.read<ChatCubit>().addMessage(ChatMessage(
                        text: value, chatMessageType: ChatMessageType.bot));
                  });
                  _textController.clear();
                  Future.delayed(const Duration(milliseconds: 50))
                      .then((value) => _scrollDown());
                });
              },
            ),
          ),
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Widget _buildListMessage() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            var message = state.messages[index];
            return ChatMessageWidget(
              text: message.text,
              chatMessageType: message.chatMessageType,
            );
          },
        );
      },
    );
  }
}
