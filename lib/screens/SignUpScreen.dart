import 'package:dayas/cubits/SignUpCubit.dart';
import 'package:dayas/states/SignUpState.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:dayas/widget/standardInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    verifyPasswordController.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) {
    // Trigger Cubit
    context.read<Signupcubit>().signUp(
      emailController.text,
      passwordController.text,
      verifyPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Signupcubit(),
      child: Scaffold(
        
        backgroundColor: Colors.white,
        body: SafeArea( 
        child: SingleChildScrollView(
          child :  Center(
          child: BlocConsumer<Signupcubit, Signupstate>(
            listener: (context, state) {
              if (state is SignupstateLoaded) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // going to fix this to route 
                      builder: (_) => const DummyHomeScreen()),
                );
              } else if (state is SignupstateError) {
                // Show error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return 
              Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height : 50),
                  Image.asset("assets/images/sign_up.png",
                      height: 104, width: 76),
                  Text("Sign Up",
                      style: LineStyles.header
                          .copyWith(color: AppColors.darkGrey)),
                  const SizedBox(height: 20),
                  GetInput("Email", "Your Email",
                      controller: emailController),
                  const SizedBox(height: 10),
                  GetInput("Password", "Enter Your Password",
                      controller: passwordController, obscureText: true),
                  const SizedBox(height: 10),
                  GetInput("Verify Password", "Re-enter Your Password",
                      controller: verifyPasswordController,
                      obscureText: true),
                  const SizedBox(height: 20),
                  Text("I accept the terms and privacy policy" , style: LineStyles.act_subtitle), 
                  const SizedBox(height: 20),
                  if (state is SignupstateLoading)
                    CircularProgressIndicator(color: AppColors.bluePastel)
                  else
                    getButton("Signup", AppColors.bluePastel, onTap: () {
                      signUp(context);
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
                      child: Text("Log in" , style: LineStyles.act_subtitle.copyWith(color: AppColors.bluePastel , decoration: TextDecoration.underline))
                    )
                  ],)
                ],
              )
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

// Dummy home page
class DummyHomeScreen extends StatelessWidget {
  const DummyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Welcome to Home 🎉")),
    );
  }
}
