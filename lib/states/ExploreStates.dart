import 'package:dayas/models/heroModel.dart';

class Explorestates {}
class ExploreInitialState extends Explorestates {}
class ExploreLoadingState extends Explorestates {}
class ExploreSuccessState extends Explorestates {
  List<Heromodel> herolist ; 
  ExploreSuccessState({required this.herolist});
}
class ExploreErrorState extends Explorestates {
  String error ; 
  ExploreErrorState({required this.error});
}