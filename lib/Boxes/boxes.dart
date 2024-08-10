
import 'package:hive/hive.dart';

import '../Model/notes_model.dart';

class Boxes{
  static Box<NotesModel> getData()=>Hive.box<NotesModel>("notes");
}