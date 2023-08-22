import 'package:flutter/material.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_bloc.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_events.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_states.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/list_of_infant.dart';
import 'package:neoroo_app/utils/custom_loader.dart';

class SkinToSkinTimeScreen extends StatefulWidget {
  const SkinToSkinTimeScreen({Key? key}) : super(key: key);

  @override
  State<SkinToSkinTimeScreen> createState() => _SkinToSkinTimeScreenState();
}

class _SkinToSkinTimeScreenState extends State<SkinToSkinTimeScreen> {
  getInfantsFromServer() {
    BlocProvider.of<FetchBabyBloc>(context).add(GetInfantsFromServer(context));
  }

  @override
  void initState() {
    getInfantsFromServer();

    super.initState();
  }

  List<Infant> infantOnServer = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110, 42, 127, 1),
        title: Text('Skin - Skin Activity'),
      ),
      body: BlocConsumer<FetchBabyBloc, FetchBabyStates>(
        listener: (context, state) {
          print(state);
          if (state is FetchBabyInitialState) {
            BlocProvider.of<FetchBabyBloc>(context)
                .add(GetInfantsFromServer(context));
          } else if (state is FetchInfantFromServerSuccess) {
            setState(() {
              infantOnServer = state.infantList;
            });
          }
        },
        builder: (context, state) {
          if (state is FetchBabyTriggeredState) {
            return Container(
              child: Center(child: CustomCircularProgressIndicator()),
            );
          } else if (state is FetchInfantFromServerSuccess) {
            return RefreshIndicator(
              onRefresh: () => getInfantsFromServer(),
              child: ListOfInfantsOnServer(
                infantOnServer: state.infantList,
              ),
            );
          }
          return Container(
            child: Center(child: CustomCircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
