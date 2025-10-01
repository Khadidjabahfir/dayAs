import 'package:dayas/cubits/chatCubit.dart';
import 'package:dayas/models/heroModel.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/states/chatStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/chatOutline.dart';
import 'package:dayas/widget/standardButton.dart';
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
            if (herolist.isEmpty) return ChatNotFound(); 
            else return DisplayChat(herolist); 
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
              // add an ontap function that redirects 
            );
          },
        ),
      ),
    ],
  );
}

Widget ChatNotFound () {
  return Center(child : 
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset('assets/images/ugh.png' , width: 78 , height:79 ,), 
      SizedBox(height : 20 ) , 
      Text("No chats yet" , style : LineStyles.context.copyWith(color : AppColors.lightGrey , fontSize: 20 , fontWeight: FontWeight.normal)),
      SizedBox(height: 70,) , 
      getButton("Explore", AppColors.purplePastel), 
      SizedBox(height: 5,) , 
      Text('spend a day as a role model to unlock one!', style: LineStyles.act_subtitle.copyWith(fontWeight: FontWeight.normal)) 
    ]
    )
  ); 
}


