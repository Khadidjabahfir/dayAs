import 'package:dayas/models/heroModel.dart';
import 'package:dayas/states/ExploreStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Explorecubit extends Cubit<Explorestates> {
  Explorecubit() : super(ExploreInitialState());
  void fetchHeroes() async {
    emit(ExploreLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2)); 
      List<Heromodel> heroes = [
        Heromodel(name: 'Hero 1', role: 'Description 1' , imageUrl: 'assets/images/test_hero.png', color: 'purple'),
        Heromodel(name: 'Hero 2', role: 'Description 2' , imageUrl: 'assets/images/test_hero.png' , color : 'blue'),
        Heromodel(name: 'Hero 1', role: 'Description 1' , imageUrl: 'assets/images/test_hero.png', color: 'yellow'),
        Heromodel(name: 'Hero 2', role: 'Description 2' , imageUrl: 'assets/images/test_hero.png' , color : 'blue'),
      ];
      emit(ExploreSuccessState(herolist: heroes));
    } catch (e) {
      emit(ExploreErrorState(error: '$e'));
    }
  }
}