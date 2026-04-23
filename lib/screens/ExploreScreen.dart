import 'package:dayas/cubits/ExploreCubit.dart';
import 'package:dayas/states/ExploreStates.dart';
import 'package:dayas/styles/colors.dart';
import 'package:dayas/widget/hero/herocard.dart';
import 'package:dayas/widget/searchwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Explorescreen extends StatelessWidget {
  const Explorescreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Explorecubit()..fetchHeroes(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: BlocConsumer<Explorecubit, Explorestates>(
              listener: (context, state) {
                if (state is ExploreErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ExploreInitialState ||
                    state is ExploreLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is ExploreSuccessState) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      getSearchWidget(),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: state.herolist.length,
                          itemBuilder: (context, index) {
                            final hero = state.herolist[index];
                            final color = getColorFromString(hero.color);
                            return GetHeroCard(
                              context , 
                              hero.name,
                              hero.role,
                              hero.imageUrl,
                              color,
                              hero 
                            );
                          },
                        ),
                      ),
                    ],
                  );

                } else if (state is ExploreErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Color getColorFromString(String color) {
    if (color == 'purple') return AppColors.purplePastel;
    if (color == 'pink') return AppColors.pinkPastel;
    if (color == 'blue') return AppColors.bluePastel;
    if (color == 'yellow') return AppColors.yellowPastel;
    return AppColors.lightGrey;
}