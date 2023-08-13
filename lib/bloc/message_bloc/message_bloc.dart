import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/message_bloc/message_boc_states.dart';
import 'package:neoroo_app/bloc/message_bloc/message_event.dart';
import 'package:neoroo_app/models/chat_user.dart';
import 'package:neoroo_app/models/message_model.dart';
import 'package:neoroo_app/repository/message_repository.dart';

class MessageBloc extends Bloc<MessageEvent, MessageBlocState> {
  final MessageRepository messageRepository;
  MessageBloc({required this.messageRepository}) : super(MessageInitial()) {
    on<GetUsersFromDhis2>(getUserFromDhis2);
    on<GetConversationOfUser>(getConversationOfUser);
    on<FetchChatsOfChatRoom>(fetchChatsOfChatRoom);
    on<UserBackFromChatRoom>(userBackFromChatRoom);
    on<CreateCharRoomForThisUser>(createChatRoom);
    on<SendMessageEvent>(sendMessage);
    on<SeacrchUserInList>(searchUserInTheList);
  }
  getUserFromDhis2(
      GetUsersFromDhis2 event, Emitter<MessageBlocState> emitter) async {
    emitter(GetUserFromDhis2InitialState());
    var response = await messageRepository.getUsersFromDhis2();

    if (response is List<ChatUser>) {
      List<ChatUser> alreadyPresentChats = event.userAlreadyPresent;
      List<ChatUser> allTheUsersFromDhis2 = response;

      List<ChatUser> listToEmit = [
        ...alreadyPresentChats,
        ...allTheUsersFromDhis2.where((user) => !alreadyPresentChats
            .any((element) => element.recieverId == user.recieverId)),
      ];

      emitter(GetUserFromDhis2Sucessful(allUsersAvailableForChat: listToEmit));
    } else {
      emitter(GetUSerFromDhis2Failed());
    }
  }

  getConversationOfUser(
      GetConversationOfUser event, Emitter<MessageBlocState> emitter) async {
    var response = await messageRepository.getAllConversationsOfTheUser();

    // ignore: unnecessary_type_check
    if (response is List<ChatUser>) {
      emitter(UserChatList(response));
    }
  }

  fetchChatsOfChatRoom(
      FetchChatsOfChatRoom event, Emitter<MessageBlocState> emitter) async {
    emitter(FetchingChatsOfChatsRoomInitialState());
    var response = await messageRepository
        .getConverationsOfUserForTheChatRoom(event.chatUser);
    if (response is List<Messages>) {
      emitter(FetchingChatsOfChatRoomSuccessfulState(response));
    } else {
      emitter(FetchingChatsOfChatRoomFaildesState());
    }
  }

  userBackFromChatRoom(
      UserBackFromChatRoom event, Emitter<MessageBlocState> emitter) {
    emitter(StoreChatUsers(event.chatUser));
  }

  createChatRoom(CreateCharRoomForThisUser event,
      Emitter<MessageBlocState> emitter) async {
    emitter(CreateChatRoomInitialState());
    var response = await messageRepository.createChatRoom(event.chatUser);
    if (response is ChatUser) {
      emitter(CreateChatRoomSucessful(response));
    } else {
      emitter(CreateChatUserFaildedState());
    }
  }

  sendMessage(SendMessageEvent event, Emitter<MessageBlocState> emitter) async {
    emitter(SendMessageInitialState());
    var response =
        await messageRepository.sendMessage(event.chatUser, event.message);
    if (response == "Successfull") {
      emitter(SendMessageSuccessfullState());
    } else {
      emitter(SendMessageFailedState());
    }
  }

  searchUserInTheList(
      SeacrchUserInList event, Emitter<MessageBlocState> emitter) async {
    emitter(SearchResultList(event.userChatList));
    List<ChatUser> searchResult = [];
    for (var user in event.userChatList) {
      if (user.recieverName.toLowerCase().contains(event.query.toLowerCase())) {
        searchResult.add(user);
      }
    }
    emitter(SearchResultList(searchResult));
  }
}
