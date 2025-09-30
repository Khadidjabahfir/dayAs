import 'package:dayas/cubits/CustomCubit.dart';
import 'package:dayas/models/heroModel.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/states/Customstates.dart';
import 'package:dayas/widget/customWithSubTasks.dart';
import 'package:dayas/widget/standardButton.dart';
import 'package:dayas/widget/standardHeroCircularProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomizePlanPage extends StatelessWidget {
  final Heromodel hero;

  const CustomizePlanPage({Key? key, required this.hero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = getColorFromString(hero.color);

    return BlocProvider(
      create: (_) => CustomCubit()..loadTasks(hero.name, hero.tasks ?? []),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GetHeroCircularProfile(hero.imageUrl, color, hero.name, hero.role),
              const SizedBox(height: 20),
               Expanded(
                child: Center (
                  child : ConstrainedBox( 
                    constraints: const BoxConstraints(
                      maxWidth: 600, 
                    ),
                    child: BlocBuilder<CustomCubit, CustomStates>(
                      builder: (context, state) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return CustomTaskWithSubtasks(
                              task: task,
                              index: index,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
               ), 
               SizedBox(height: 20,),
              getButton('Finalize', color, onTap: () {
                final tasks = context.read<CustomCubit>().state.tasks;
                print("Finalized tasks: $tasks");
              }),
              SizedBox(height : 30), 
            ],
          ),
        )
      ),
    );
  }
}