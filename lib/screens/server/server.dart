// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neoroo_app/bloc/server_bloc/server_bloc.dart';
import 'package:neoroo_app/bloc/server_bloc/server_bloc_events.dart';
import 'package:neoroo_app/bloc/server_bloc/server_bloc_states.dart';
import 'package:neoroo_app/screens/authentication/login/login.dart';
import 'package:neoroo_app/screens/home/seperator.dart';
import 'package:neoroo_app/screens/main_screen/main_screen.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  void initializeServerComponents() {
    BlocProvider.of<ServerBloc>(context).add(ConnectToServer());
  }

  void navigationOnSuccess() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
        (route) => false,
      );
    });
  }

  void navigationOnFaliure() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    initializeServerComponents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: BlocConsumer<ServerBloc, ServerBlocStates>(
          listener: (context, state) {
        if (state is ConnectedToServer) {
          print(state);
          BlocProvider.of<ServerBloc>(context).add(CheckForAttributes());
        } else if (state is AttributesPrepared) {
          print(state);

          BlocProvider.of<ServerBloc>(context).add(CheckForEntityTypes());
        } else if (state is ServerPrepared) {
          print(state);
          navigationOnSuccess();
        } else if (state is ConnectionFailed) {
          navigationOnFaliure();
        }
      }, builder: (context, state) {
        if (state is ServerStateInitial) {
          print(state);
          return StateContainer(
            message: "Please wait while we initialize the process",
            serverPrepare: false,
          );
        } else if (state is ConnectingToServerState) {
          print(state);
          return StateContainer(
            message: "Please wait while we connect to server.",
            serverPrepare: false,
          );
        } else if (state is ConnectedToServer) {
          print(state);
          return StateContainer(
            message: "Please wait while we check server for attributes.",
            serverPrepare: false,
          );
        } else if (state is FetchAttributes) {
          print(state);
          return StateContainer(
            message: "Please wait while we fetch attributes.",
            serverPrepare: false,
          );
        } else if (state is PrepareAttributes) {
          print(state);
          return StateContainer(
            message: "Please wait while we prepare tracked attributes",
            serverPrepare: false,
          );
        } else if (state is FetchTrackedEntityType) {
          print(state);
          return StateContainer(
            message: "Please wait while we fetch tracked program",
            serverPrepare: false,
          );
        } else if (state is PrepareEntityType) {
          print(state);
          return StateContainer(
            message: "Please wait while we prepare the tracked program.",
            serverPrepare: false,
          );
        } else if (state is ServerPrepared) {
          print(state);
          return StateContainer(
            message: "Server Prepared sucessfully",
            serverPrepare: true,
          );
        } else if (state is ConnectionFailed) {
          print(state);
          return StateContainer(
            message: state.exception.toString(),
            serverPrepare: false,
          );
        }
        return StateContainer(
          message: "Error please reload the application !!!!",
          serverPrepare: false,
        );
      }),
    );
  }
}

class StateContainer extends StatelessWidget {
  final String message;
  final bool serverPrepare;
  const StateContainer({
    Key? key,
    required this.message,
    required this.serverPrepare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    serverPrepare
                        ? Icon(Icons.check,
                            color: Color.fromRGBO(110, 120, 247, 1))
                        : CircularProgressIndicator(
                            color: Color.fromRGBO(110, 120, 247, 1)),
                    Seperator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
