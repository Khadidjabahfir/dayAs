import 'package:dayas/models/routineTaskModel.dart';

class Heromodel {
  String name ; 
  String role ; 
  String imageUrl ;
  String color  ; 
  List<routineTasksModel>? tasks;
  Heromodel({required this.name, required this.role, required this.imageUrl, required this.color , this.tasks  } );
}


