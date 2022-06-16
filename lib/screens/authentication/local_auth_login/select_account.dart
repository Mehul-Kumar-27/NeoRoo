import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SelectAccount extends StatelessWidget {
  final Map<String, List<String>> data;
  const SelectAccount({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer(
        listener: (context,state){},
        builder: (context,state)=>ModalProgressHUD(
          child: Scaffold(),
          inAsyncCall: false,
        ),
      ),
    );
  }
}
