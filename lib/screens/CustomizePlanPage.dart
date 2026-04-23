import 'package:dayas/cubits/CustomCubit.dart';
import 'package:dayas/models/heroModel.dart';
import 'package:dayas/screens/EndingTheChallengeScreen.dart';
import 'package:dayas/screens/ExploreScreen.dart';
import 'package:dayas/states/Customstates.dart';
import 'package:dayas/styles/lineStyles.dart';
import 'package:dayas/widget/customization/customWithSubTasks.dart';
import 'package:dayas/widget/standardWidgets/standardButton.dart';
import 'package:dayas/widget/hero/standardHeroCircularProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomizePlanPage extends StatelessWidget {
  final Heromodel hero;
  final bool isfinal ; 

  const CustomizePlanPage({Key? key, required this.hero , required this.isfinal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = getColorFromString(hero.color);
    
    return BlocProvider(
      create: (_) {
        final cubit = CustomCubit();
        if (isfinal) {
          cubit.loadSavedPlans(); 
        } else {
          cubit.loadTasks(hero.name, hero.tasks ?? []);
        }
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('DayAs',
              style:LineStyles.header),
          backgroundColor: Colors.white,
          centerTitle: true,
        ), 
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              getHeroCircularProfile(hero.imageUrl, color, hero.name, hero.role),
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
               if (!isfinal )
               getButton('Finalize', color, onTap: () {
                final tasks = context.read<CustomCubit>().state.tasks;
                print("Finalized tasks: $tasks");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomizePlanPage(hero: hero, isfinal: true),
                  ),
                );
              }),
              if (isfinal ) 
              getButton('End Routine', color, onTap: () async{
                final score = await context.read<CustomCubit>().endRoutine();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EndingTheChallengeRoutine(score :score),
                  ),
                );
              }),
              SizedBox(height : 30), 
              
            ],
          ),
        )
      ),
    );
  }
}