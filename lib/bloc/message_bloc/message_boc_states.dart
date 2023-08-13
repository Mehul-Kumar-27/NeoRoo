import 'package:neoroo_app/models/chat_user.dart';
import 'package:neoroo_app/models/message_model.dart';

class MessageBlocState {}

class MessageInitial extends MessageBlocState {}

class GetUserFromDhis2InitialState extends MessageBlocState {}

class GetUserFromDhis2Sucessful extends MessageBlocState {
  final List<ChatUser> allUsersAvailableForChat;

  GetUserFromDhis2Sucessful({required this.allUsersAvailableForChat});
}

class GetUSerFromDhis2Failed extends MessageBlocState {}

class UserChatList extends MessageBlocState {
  final List<ChatUser> userChatList;

  UserChatList(this.userChatList);
}

class FetchingChatsOfChatsRoomInitialState extends MessageBlocState {}

class FetchingChatsOfChatRoomSuccessfulState extends MessageBlocState {
  final List<Messages> chatsOfThisRoom;

  FetchingChatsOfChatRoomSuccessfulState(this.chatsOfThisRoom);
}

class FetchingChatsOfChatRoomFaildesState extends MessageBlocState {}

class StoreChatUsers extends MessageBlocState {
  final List<ChatUser> chatUsersFetched;

  StoreChatUsers(this.chatUsersFetched);
}

class StoreChatsOfTheChatRooms extends MessageBlocState {
  final Map<String, List<Messages>> chatRoomConversationFetched;

  StoreChatsOfTheChatRooms(this.chatRoomConversationFetched);
}

class CreateChatRoomSucessful extends MessageBlocState {
  final ChatUser chatUser;

  CreateChatRoomSucessful(this.chatUser);
}

class CreateChatUserFaildedState extends MessageBlocState {}

class CreateChatRoomInitialState extends MessageBlocState {}

class SendMessageInitialState extends MessageBlocState {}

class SendMessageSuccessfullState extends MessageBlocState {}

class SendMessageFailedState extends MessageBlocState {}

class SearchResultList extends MessageBlocState {
  final List<ChatUser> searchResultList;

  SearchResultList(this.searchResultList);
}
