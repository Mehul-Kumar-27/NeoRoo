import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/message_bloc/message_bloc.dart';
import 'package:neoroo_app/bloc/message_bloc/message_boc_states.dart';
import 'package:neoroo_app/bloc/message_bloc/message_event.dart';
import 'package:neoroo_app/models/chat_user.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/secure_storage_repository.dart';
import 'package:neoroo_app/screens/messaging/chat_scree.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  TextEditingController searchController = TextEditingController();

  late BuildContext _contextNew;
  @override
  void initState() {
    _contextNew = context;
    BlocProvider.of<MessageBloc>(context).add(GetConversationOfUser());

    super.initState();
  }

  refreshIndcatorFunction() async {
    setState(() {
      chatListToDisplay = [];
      previousChats = [];
      newChats = [];
      fetchedTheUserChats = false;
      taps = 0;
    });
    BlocProvider.of<MessageBloc>(context).add(GetConversationOfUser());
  }

  bool fetchedTheUserChats = false;
  bool showingChatsUserPreviouslyDone = true;
  List<ChatUser> chatListToDisplay = [];
  List<ChatUser> previousChats = [];
  List<ChatUser> newChats = [];
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 42, 127, 1),
        toolbarHeight: 90,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 22, bottom: 10),
              child: Text(
                "Messages",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            BlocBuilder<MessageBloc, MessageBlocState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 340,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(88, 34, 102, 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1.0),
                            child: SizedBox(
                              height: 40,
                              width: 260,
                              child: TextField(
                                cursorColor: Colors.white.withOpacity(0.9),
                                controller: searchController,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8)),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6)),
                                    hintText: "Search For User to chat ..."),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              searchController.clear();
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      body: BlocConsumer<MessageBloc, MessageBlocState>(
        listener: (context, state) {
          if (state is UserChatList) {
            setState(() {
              fetchedTheUserChats = true;
              previousChats = state.userChatList;
              chatListToDisplay = state.userChatList;
            });
          }
          if (state is GetUserFromDhis2Sucessful) {
            setState(() {
              if (taps == 0) {
                chatListToDisplay = state.allUsersAvailableForChat;
                taps++;
              }
              newChats = state.allUsersAvailableForChat;
            });
          }
          if (state is StoreChatUsers) {
            setState(() {
              chatListToDisplay = state.chatUsersFetched;
            });
          }
        },
        builder: (context, state) {
          if (state is GetUserFromDhis2Sucessful ||
              state is UserChatList ||
              state is StoreChatUsers) {
            return RefreshIndicator(
              onRefresh: () => refreshIndcatorFunction(),
              child: ChatListOfUser(
                chatList: chatListToDisplay,
                newContext: _contextNew,
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(
                  color: Color.fromRGBO(110, 42, 127, 1),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: fetchedTheUserChats
          ? FloatingActionButton(
              backgroundColor: const Color.fromRGBO(110, 42, 127, 1),
              onPressed: () {
                if (taps == 0) {
                  BlocProvider.of<MessageBloc>(context)
                      .add(GetUsersFromDhis2(previousChats));
                }

                setState(() {
                  showingChatsUserPreviouslyDone =
                      !showingChatsUserPreviouslyDone;
                  if (showingChatsUserPreviouslyDone) {
                    chatListToDisplay = previousChats;
                  } else {
                    chatListToDisplay = newChats;
                  }
                });
              },
              child: showingChatsUserPreviouslyDone
                  ? const Icon(Icons.people_alt_rounded)
                  : const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
            )
          : Container(),
    );
  }
}

class ChatListOfUser extends StatelessWidget {
  final List<ChatUser> chatList;
  final BuildContext newContext;
  const ChatListOfUser({
    Key? key,
    required this.chatList,
    required this.newContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            HiveStorageRepository hiveStorageRepository =
                HiveStorageRepository(SecureStorageRepository);
            Profile profile = await hiveStorageRepository.getUserProfile();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(chatUser: chatList[index], profile: profile,))).then((value) {
              BlocProvider.of<MessageBloc>(newContext)
                  .add(UserBackFromChatRoom(chatList));
            });
          },
          child: ListTile(
            leading: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Icon(Icons.person),
            ),
            title: Text(chatList[index].recieverName),
            subtitle: Text(
                chatList[index].conversationId ?? "Connect with the user .."),
          ),
        );
      },
      itemCount: chatList.length,
    );
  }
}
