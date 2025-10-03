import 'package:dayas/cubits/UserCubit.dart';
import 'package:dayas/models/UserModel.dart';
import 'package:dayas/screens/LoginScreen.dart';
import 'package:dayas/states/userStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:dayas/widget/standardInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({Key? key}) : super(key: key);

  Future<String?> _getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getSavedEmail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No email saved. Please log in."),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Loginscreen()),
                      );
                    },
                    child: const Text("Go to Login"),
                  ),
                ],
              ),
            ),
          );
        }

        final email = snapshot.data!;
        return BlocProvider(
          create: (_) => Usercubit()..fetchUser(email),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<Usercubit, Userstates>(
              builder: (context, state) {
                if (state is UserstatesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserstatesLoaded) {
                  return ProfileAccountInfo(user: state.user, email: email);
                } else if (state is UserstatesError) {
                  return Center(child: Text("Error: ${state.error}"));
                } 
                return ProfileAccountInfo(user: UserModel(email: email, name: "", birthday: "", profilePicUrl: "", nickName: ""), email: email);
              },
            ),
          ),
        );
      },
    );
  }
}

class ProfileAccountInfo extends StatefulWidget {
  final UserModel user;
  final String email;

  const ProfileAccountInfo({Key? key, required this.user, required this.email}) : super(key: key);

  @override
  State<ProfileAccountInfo> createState() => _ProfileAccountInfoState();
}
class _ProfileAccountInfoState extends State<ProfileAccountInfo> {
  late TextEditingController _usernameController;
  late TextEditingController _birthdayController;

  String get email => widget.email;
 

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.name ?? '');
    _birthdayController = TextEditingController(text: widget.user.birthday ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/excited.png' , width : 78 , height : 90)  , 
            Text(
              "Ready to tell us more about you!!",
              style: LineStyles.context.copyWith(
                color: AppColors.lightGrey,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),

           
            GetInput(
              "Username",
              "Your username",
              controller: _usernameController,
            ),
            const SizedBox(height: 10),

            
            GetInput(
              "Birthday",
              "Your birthday",
              isDate: true,
              controller: _birthdayController,
              context: context,
            ),
            const SizedBox(height: 30),
            BlocBuilder<Usercubit, Userstates>(
              builder: (context, state) {
                if (state is UserSavingLoading) {
                  return const CircularProgressIndicator(color: AppColors.bluePastel);
                } else if (state is UserstatesError) {
                  return Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return getButton(
                  "Save",
                  AppColors.bluePastel,
                  onTap: () {
                    context.read<Usercubit>().storeUser(
                          email,
                          _usernameController.text,
                          _birthdayController.text,
                        );
                  },
                );
              },
            ),

            
            SizedBox(height : 20) , 
          ],
        ),
      ),
    );
  }
}
