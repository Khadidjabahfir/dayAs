import 'package:dayas/cubits/chatCubit.dart';
import 'package:dayas/models/heroModel.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/states/chatStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/widget/chatOutline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Chatcubit()..fetchRooms(), 
      child: Scaffold(
        backgroundColor: Colors.white , 
        body : BlocBuilder<Chatcubit , ChatStates> (
          builder: (context, state){
          if (state is ChatStateLoading) {
            return Center(
              child : CircularProgressIndicator(color: AppColors.yellowPastel)
            ); 
          }else if (state is ChatStateLoaded) {
            List<Heromodel> herolist =  state.herolist ; 
            return DisplayChat(herolist); 
             
          }else if (state is ChatStateError ){
            return Center(child: Text(state.error )); 
          }else {
            return Center(child : Text("Error")); 
          }
        })
      ),
    ); 
  }
}
Widget DisplayChat(List<Heromodel> list) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: 40),
      Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {

            final hero = list[index];
            return GetChatOutline(
              getColorFromString(hero.color),
              hero.imageUrl,
              hero.name,
            );
          },
        ),
      ),
    ],
  );
}


