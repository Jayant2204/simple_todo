import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_todo/app/models/Todo.dart';

class TodoController extends GetxController {
  var todoList = List<Todo>().obs;

  @override
  void onInit() {
    List savedTodo = GetStorage().read<List>("todo");
    if (!savedTodo.isNull) {
      todoList = savedTodo.map((e) => Todo.fromJson(e)).toList().obs;
    }

    //Write to Storage whenever there's any change in todoList.
    ever(todoList, (_) {
      GetStorage().write("todo", todoList.toList());
    });
    super.onInit();
  }
}
