import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo/app/controllers/todoController.dart';
import 'package:simple_todo/app/views/todoPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    bool isLightTheme = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Todo List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {
              Get.changeTheme(
                isLightTheme ? ThemeData.dark() : ThemeData.light(),
              );
              isLightTheme = !isLightTheme;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(TodoPage(), transition: Transition.downToUp);
        },
      ),
      body: Container(
        child: Obx(
          () => ListView.separated(
              //To show the list in cronological order reverse = true
              reverse: true,
              shrinkWrap: true,
              // Swipe horizontal on any taskList to remove
              itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      // To notify user the task has been removed and give user a chance
                      // undo the delete action.
                      var removed = todoController.todoList[index];
                      todoController.todoList.removeAt(index);
                      Get.snackbar('Task removed',
                          'The task "${removed.title}" was successfully removed.',
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.red.withOpacity(0.4),
                          // Undo Button
                          mainButton: FlatButton(
                            child: Text('Undo'),
                            onPressed: () {
                              if (removed.isNull) {
                                return;
                              }
                              todoController.todoList.insert(index, removed);
                              removed = null;
                              if (Get.isSnackbarOpen) {
                                Get.back();
                              }
                            },
                          ));
                    },
                    child: ListTile(
                      title: Text(
                          todoController.todoList[index].title.capitalizeFirst,
                          style: (todoController.todoList[index].isFinished ??
                                  false)
                              ? TextStyle(
                                  color: Colors.blueGrey,
                                  decoration: TextDecoration.lineThrough)
                              : TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .color)),
                      subtitle: Text(todoController.todoList[index].description,
                          style: (todoController.todoList[index].isFinished ??
                                  false)
                              ? TextStyle(
                                  color: Colors.grey,
                                )
                              : TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color)),
                      onTap: () {
                        // pass index to edit the task
                        Get.to(TodoPage(
                          index: index,
                        ));
                      },
                      leading: Checkbox(
                        value: todoController.todoList[index].isFinished,
                        onChanged: (v) {
                          var changed = todoController.todoList[index];
                          changed.isFinished = v;
                          todoController.todoList[index] = changed;
                        },
                      ),
                      //visual representation of when the task was created
                      trailing: Text(timeago.format(
                          todoController.todoList[index].createdAt,
                          locale: 'en_short')),
                    ),
                  ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: todoController.todoList.length),
        ),
      ),
    );
  }
}
