import 'dart:convert';

import 'package:neoroo_app/models/chat_user.dart';
import 'package:neoroo_app/models/message_model.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/network/message_network_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class MessageRepository {
  final MessageNetwrokApiClient messageNetwrokApiClient;
  final HiveStorageRepository hiveStorageRepository;

  MessageRepository(
      {required this.messageNetwrokApiClient,
      required this.hiveStorageRepository});
  Future getUsersFromDhis2() async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String username = profile.username;
    String password = profile.password;
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String organizationUnitID =
        await hiveStorageRepository.getSelectedOrganisation();

    var response = await messageNetwrokApiClient.getUsersFromTheDhis2Server(
        username, password, serverURL, organizationUnitID);
    if (response.statusCode == 200) {
      // print(response.body);
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<dynamic> usersJson = jsonMap['users'];
      print(usersJson);
      List<ChatUser> chatUsers = usersJson.map((userJson) {
        return ChatUser.fromJson(userJson);
      }).toList();

      return chatUsers;
    } else {
      print(response.statusCode);
      print(response.body);
    }

    return response;
  }

  Future<List<ChatUser>> getAllConversationsOfTheUser() async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String username = profile.username;
    String password = profile.password;
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String userId = profile.userId;

    final response = await messageNetwrokApiClient.getAllConversationsOfTheUser(
        username, password, serverURL);

    if (response.statusCode == 200) {
      print(response.body);
      final messagesJson = jsonDecode(response.body);
      final messageConversation =
          messagesJson["messageConversations"] as List<dynamic>;

      final List<ChatUser> chatUserList = [];

      for (var conversation in messageConversation) {
        final List<String> ids =
            (conversation['displayName'] as String).split("\$\$");
        final String conversationId = conversation["id"];

        if (ids.contains(userId)) {
          for (var id in ids) {
            if (id != userId) {
              final recipentNameResponse = await messageNetwrokApiClient
                  .lookUpToAUser(username, password, serverURL, id);
              final recieverDetails = jsonDecode(recipentNameResponse.body);
              final String recieverName = recieverDetails["displayName"];

              final chatUser = ChatUser(
                recieverName: recieverName,
                recieverId: id,
                conversationDisplayName: conversation['displayName'],
                conversationId: conversationId,
              );

              chatUserList.add(chatUser);
            }
          }
        }
      }

      return chatUserList;
    } else {
      throw Exception("Failed to retrieve conversations");
    }
  }

  Future getConverationsOfUserForTheChatRoom(ChatUser chatUser) async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String username = profile.username;
    String password = profile.password;
    String serverURL = await hiveStorageRepository.getOrganisationURL();

    try {
      var response =
          await messageNetwrokApiClient.getConverationsOfUserForTheChatRoom(
              username, password, serverURL, chatUser.conversationId!);

      if (response.statusCode == 200) {
        var messageData = jsonDecode(response.body);
        List<Messages> chatsInTheRoom = [];
        final messages = messageData['messages'];
        final messageTexts = messages.map((m) => m['displayName']).toList();
        for (int i = 1; i < messageTexts.length; i++) {
          final conversation = jsonDecode(messageTexts[i]);
          chatsInTheRoom.add(Messages.fromJson(conversation));
        }
        return chatsInTheRoom;
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {}
  }

  Future createChatRoom(ChatUser chatUser) async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String username = profile.username;
    String password = profile.password;
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String userId = profile.userId;
    String recipientId = chatUser.recieverId;
    List<String> recipientList = [];
    try {
      recipientList.add(recipientId);
      var response = await messageNetwrokApiClient.createChatRoom(
          username, password, serverURL, recipientList, userId);

      if (response.statusCode == 201) {
        print(response.body);
        var getChatRoomIdResponse = await messageNetwrokApiClient
            .getAllConversationsOfTheUser(username, password, serverURL);
        if (getChatRoomIdResponse.statusCode == 200) {
          final messagesJson = jsonDecode(getChatRoomIdResponse.body);
          final messageConversation =
              messagesJson["messageConversations"] as List<dynamic>;

          String displayName = "$userId\$\$${chatUser.recieverId}";
          for (var conversation in messageConversation) {
            if (conversation["displayName"] == displayName) {
              ChatUser newChatUserAdded = ChatUser(
                  recieverName: chatUser.recieverName,
                  recieverId: chatUser.recieverId,
                  conversationDisplayName: displayName,
                  conversationId: conversation["id"]);
              return newChatUserAdded;
            }
          }
        } else {
          print(response.statusCode);
          print(response.body);
          return "Unknown Error Occured";
        }
      } else {
        print(response.statusCode);
        print(response.body);
        return "Unknown Error Occured";
      }
    } catch (e) {
      return "Unknown Error Occured : ${e.toString()}";
    }
  }

  Future sendMessage(ChatUser chatUser, String message) async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String username = profile.username;
    String password = profile.password;
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String userId = profile.userId;
    String recipientId = chatUser.recieverId;
    List<String> recipientList = [recipientId];
    try {
      var response = await messageNetwrokApiClient.sendMessage(
          username,
          password,
          serverURL,
          message,
          recipientList,
          chatUser.conversationId!,
          userId);
      if (response.statusCode == 201) {
        print(response.body);
        return "Successfull";
      } else {
        print(response.statusCode);
        print(response.body);
        return "Failed";
      }
    } catch (e) {
      return "Failed";
    }
  }
}
