import 'package:dayas/widget/navBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayas/cubits/CustomCubit.dart';
import 'package:dayas/cubits/ExploreCubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomCubit>(
          create: (context) => CustomCubit(),
        ),
        BlocProvider<Explorecubit>(
          create: (_) => Explorecubit()..fetchHeroes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DayAs',
        home: const BottomBar(), 
      ),
    );
  }
}
