import 'package:dayas/models/heroModel.dart';
import 'package:dayas/models/routineTaskModel.dart';
import 'package:dayas/states/ExploreStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Explorecubit extends Cubit<Explorestates> {
  Explorecubit() : super(ExploreInitialState());
  void fetchHeroes() async {
    emit(ExploreLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2)); 
      List<Heromodel> heroes = [
          Heromodel(
            name: 'Olivia Rodrigo',
            role: 'Singer-Songwriter',
            imageUrl: 'assets/images/olivia.png',
            color: 'purple',
            tasks: [
              routineTasksModel(
                taskName: 'Songwriting',
                taskStart: '09:00',
                taskEnd: '11:00',
                taskColor: 'purple',
              ),
              routineTasksModel(
                taskName: 'Rehearsal',
                taskStart: '14:00',
                taskEnd: '16:00',
                taskColor: 'purple',
              ),
              routineTasksModel(
                taskName: 'Concert',
                taskStart: '20:00',
                taskEnd: '22:00',
                taskColor: 'purple',
              ),
            ],
          ),
          Heromodel(
            name: 'SEVENTEEN',
            role: 'K-pop Group',
            imageUrl: 'assets/images/olivia.png',
            color: 'blue',
            tasks: [
              routineTasksModel(
                taskName: 'Dance Practice',
                taskStart: '10:00',
                taskEnd: '13:00',
                taskColor: 'blue',
              ),
              routineTasksModel(
                taskName: 'Recording',
                taskStart: '15:00',
                taskEnd: '18:00',
                taskColor: 'blue',
              ),
              routineTasksModel(
                taskName: 'Fan Meeting',
                taskStart: '19:00',
                taskEnd: '21:00',
                taskColor: 'blue',
              ),
            ],
          ),
        ];

      emit(ExploreSuccessState(herolist: heroes));
    } catch (e) {
      emit(ExploreErrorState(error: '$e'));
    }
  }
}