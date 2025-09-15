import 'package:dayas/cubits/LoginCubit.dart';
import 'package:dayas/screens/HomeScreen.dart';
import 'package:dayas/states/LoginStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:dayas/widget/standardInput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) {
    // Trigger Cubit
    context.read<Logincubit>().login(
      emailController.text,
      passwordController.text,
    );
  }
  @override
  Widget build (BuildContext context ){
    return BlocProvider(
      create: (_) => Logincubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea( 
        child: SingleChildScrollView(
          child : Center(
          child: BlocConsumer<Logincubit, Loginstates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // going to fix this to route 
                      builder: (_) => const DummyHomeScreen()),
                );
              } else if (state is loginErrorState) {
                // Show error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height : 50),
                  Image.asset("assets/images/sign_in.png",
                      height: 104, width: 76),
                  Text(" Sign In",
                      style: LineStyles.header
                          .copyWith(color: AppColors.darkGrey)),
                  const SizedBox(height: 20),
                   GetInput("Email", "Your Email",
                      controller: emailController),
                  const SizedBox(height: 10),
                  GetInput("Password", "Enter Your Password",
                      controller: passwordController, obscureText: true),
                  const SizedBox(height: 10),
                  SizedBox(height: 20),
                  if (state is LoginLoadingState)
                    CircularProgressIndicator( color : AppColors.purplePastel)
                  else
                    getButton("Signup", AppColors.purplePastel, onTap: () {
                      login(context);
                    }),
                  const SizedBox(height: 20),
                   Row (mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already have an account? " , style: LineStyles.act_subtitle.copyWith(color: AppColors.darkGrey)), 
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Log in" , style: LineStyles.act_subtitle.copyWith(color: AppColors.purplePastel , decoration: TextDecoration.underline))
                    )
                  ],)
                ],
              );
            },
          ),
        ),
      ),
    )
      )
    );
  }

}