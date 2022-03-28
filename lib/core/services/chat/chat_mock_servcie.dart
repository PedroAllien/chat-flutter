import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMesssage> _msgs = [];
  static MultiStreamController<List<ChatMesssage>>? _controller;
  static final _msgsStream = Stream<List<ChatMesssage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMesssage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMesssage> save(String text, ChatUser user) async {
    final _newMessage = ChatMesssage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );
    _msgs.add(_newMessage);
    _controller?.add(_msgs.reversed.toList());

    return _newMessage;
  }
}
