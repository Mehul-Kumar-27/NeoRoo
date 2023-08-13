// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/models/chat_user.dart';

class MessageEvent {}

class GetUsersFromDhis2 extends MessageEvent {
  final List<ChatUser> userAlreadyPresent;

  GetUsersFromDhis2(this.userAlreadyPresent);
}

class GetConversationOfUser extends MessageEvent {}

class SeacrchUserInList extends MessageEvent {
    final String query;
  final List<ChatUser> userChatList;

  SeacrchUserInList(
    this.query,
    this.userChatList,
  );
}

class FetchChatsOfChatRoom extends MessageEvent {
  final ChatUser chatUser;

  FetchChatsOfChatRoom(this.chatUser);
}

class UserBackFromChatRoom extends MessageEvent {
  final List<ChatUser> chatUser;

  UserBackFromChatRoom(this.chatUser);
}

class CreateCharRoomForThisUser extends MessageEvent {
  final ChatUser chatUser;

  CreateCharRoomForThisUser(this.chatUser);
}

class SendMessageEvent extends MessageEvent {
  final String message;
  final ChatUser chatUser;

  SendMessageEvent(this.message, this.chatUser);
}


