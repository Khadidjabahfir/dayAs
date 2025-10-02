import 'package:dayas/cubits/UserCubit.dart';
import 'package:dayas/models/UserModel.dart';
import 'package:dayas/states/userStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/standardInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({Key? key}) : super(key: key);
  
  

  Future<String?> _getEmailFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email'); 
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String?>(
      future: _getEmailFromPrefs(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final email = snapshot.data;
        if (email == null) {
          return Scaffold(
            body: Center(child: Text("No email saved. Please log in.")),
          );
        }

        return BlocProvider(
          create: (_) => Usercubit()..fetchUser(email),
          child: Scaffold(
            appBar: AppBar(title: Text("Profile")),
            body: BlocBuilder<Usercubit, Userstates>(
              builder: (context, state) {
                if (state is UserstatesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserstatesLoaded) {
                  TextEditingController _usernamecontroller = TextEditingController(); 
                  TextEditingController _birthdaycontroller = TextEditingController(); 
                  return ProfileAccountInfo(state.user , _usernamecontroller , _birthdaycontroller); 
                } else if (state is UserstatesError) {
                  return Center(child: Text("Error: ${state.error}"));
                }
                return Center(child: Text("No user data"));
              },
            ),
          ),
        );
      },
    );
  }
}
Widget ProfileAccountInfo (UserModel user ,TextEditingController _usernamecontroller , TextEditingController _birthdaycontroller ) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/excited.png', width : 78 , height : 90 ) , 
        SizedBox(height : 15) , 
        Text("Ready to tell us more about you!!" , style : LineStyles.context.copyWith(color : AppColors.lightGrey , fontSize: 20 , fontWeight: FontWeight.normal)),
        SizedBox(height : 10) , 
        // profile infor boxes 
        GetInput("Username", "Your username" , controller: _usernamecontroller) , 
        GetInput("Birthday", "Your birthday" , isDate: true , controller: _birthdaycontroller) , 
      ],
    ),
  ); 
}
