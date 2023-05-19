import 'package:bloc/bloc.dart';
import 'package:lettutor_flutter/models/chat_gpt_model/chatmessage.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState(messages: []));

  void addMessage(ChatMessage message) {
    emit(ChatState(messages: [...state.messages, message]));
  }

  void removeAllMessages() {
    emit(ChatState(messages: []));
  }
}
