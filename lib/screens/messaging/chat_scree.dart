// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neoroo_app/bloc/message_bloc/message_bloc.dart';
import 'package:neoroo_app/bloc/message_bloc/message_boc_states.dart';
import 'package:neoroo_app/bloc/message_bloc/message_event.dart';
import 'package:neoroo_app/models/chat_user.dart';
import 'package:neoroo_app/models/message_model.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/secure_storage_repository.dart';
import 'package:neoroo_app/screens/messaging/chat_tile.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/custom_loader.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatUser chatUser;
  Profile profile;
  ChatScreen({
    Key? key,
    required this.chatUser,
    required this.profile,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  initialiseChatRoom() async {
    if (chatUser.conversationId == null) {
      BlocProvider.of<MessageBloc>(context)
          .add(CreateCharRoomForThisUser(widget.chatUser));
    } else {
      BlocProvider.of<MessageBloc>(context).add(FetchChatsOfChatRoom(chatUser));
    }
  }

  int longPollingCount = 0;

  longPolling() async {
    while (mounted) {
      BlocProvider.of<MessageBloc>(context).add(FetchChatsOfChatRoom(chatUser));
      await Future.delayed(Duration(seconds: 10));
    }
  }

  late ChatUser chatUser;
  late bool isChatRoomAvailable;

  @override
  void initState() {
    chatUser = widget.chatUser;
    initialiseChatRoom();

    if (chatUser.conversationId == null) {
      isChatRoomAvailable = false;
    } else {
      isChatRoomAvailable = true;
    }
    longPolling();
    super.initState();
  }

  List<Messages> chatsOfThisRoom = [];

  @override
  void dispose() {
    super.dispose();
  }

  bool sendingLoader = false;

  HiveStorageRepository hiveStorageRepository =
      HiveStorageRepository(SecureStorageRepository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 42, 127, 1),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 5.0, right: 10),
                child: SizedBox(
                    height: 20, width: 20, child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            InkWell(
              onTap: () {
                print(chatUser.conversationId);
              },
              child: const CircleAvatar(
                backgroundColor: Color.fromRGBO(88, 34, 102, 1),
                child: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(chatUser.recieverName)
          ],
        ),
      ),
      //M5zQapPyTZI
      body: BlocConsumer<MessageBloc, MessageBlocState>(
        listener: (context, state) {
          if (state is FetchingChatsOfChatRoomSuccessfulState) {
            setState(() {
              longPollingCount++;
              chatsOfThisRoom = state.chatsOfThisRoom;
            });
          }
          if (state is CreateChatRoomSucessful) {
            print(state.chatUser.conversationDisplayName);
            print(state.chatUser.recieverName);
            print(state.chatUser.conversationId);
            setState(() {
              chatUser = state.chatUser;
            });
          }
          if (state is CreateChatUserFaildedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Failed to create chat room !"),
              backgroundColor: Colors.red.withOpacity(0.8),
            ));
          }
          if (state is SendMessageInitialState) {
            setState(() {
              sendingLoader = true;
            });
          }
          if (state is SendMessageSuccessfullState) {
            setState(() {
              sendingLoader = false;
            });
          }
        },
        builder: (context, state) {
          if (longPollingCount == 0 &&
              state is FetchingChatsOfChatsRoomInitialState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fetching your chats"),
                SizedBox(
                  height: 10,
                ),
                CustomCircularProgressIndicator(),
              ],
            );
          }
          if (state is CreateChatRoomInitialState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Preparing chat Room with the user ..."),
                SizedBox(
                  height: 10,
                ),
                CustomCircularProgressIndicator(),
              ],
            );
          }

          return RefreshIndicator(
            onRefresh: () => initialiseChatRoom(),
            child: Column(
              children: <Widget>[
                sendingLoader
                    ? LinearProgressIndicator(
                        color: purpleTheme,
                      )
                    : Container(),
                Flexible(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.transparent,
                      );
                    },
                    itemCount: chatsOfThisRoom.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatMessageTile(
                          message: chatsOfThisRoom[index],
                          userId: widget.profile.userId);
                    },
                  ),
                ),
                const Divider(height: 1.0),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(88, 34, 102, 1).withOpacity(0.9),
                borderRadius: BorderRadius.circular(20)),
            child: _buildTextComposer(),
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 8),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: _textEditingController,
              onSubmitted: _handleSubmit,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () => _handleSubmit(_textEditingController.text),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
    if (chatUser.conversationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please initiate chatroom or refresh application")));
    } else {
      if (!sendingLoader) {
        BlocProvider.of<MessageBloc>(context)
            .add(SendMessageEvent(text, chatUser));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sending previous messages..")));
      }
    }
  }
}
