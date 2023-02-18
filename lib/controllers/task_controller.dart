import 'package:get/get.dart';
import 'package:notification/db/db_helper.dart';
import 'package:notification/models/task_model.dart';

class TaskController extends GetxController{
    Future<int> addTask({Task? task}) async{
      return await DBHelper.insert(task);
    }
}