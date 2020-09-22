import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo/app/controllers/todoController.dart';
import 'package:simple_todo/app/models/Todo.dart';

class TodoPage extends StatelessWidget {
  final int index;

  TodoPage({Key key, this.index}) : super(key: key);

  // Get instance of  Controller
  final TodoController todoController = Get.find();
  @override
  Widget build(BuildContext context) {
    String title = '';
    String description = '';
    FocusNode descriptionNode = FocusNode();
    if (!this.index.isNull) {
      title = todoController.todoList[index].title;
      description = todoController.todoList[index].description;
    }
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController descriptionController =
        TextEditingController(text: description);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.index.isNull ? "Create Task" : "Change Task"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text((this.index.isNull) ? 'Create' : 'Change'),
        onPressed: () {
          if (this.index.isNull) {
            todoController.todoList.add(Todo(
              title: titleController.text,
              description: descriptionController.text,
              createdAt: DateTime.now(),
              isFinished: false,
            ));
          } else {
            var editing = todoController.todoList[index];
            editing.title = titleController.text;
            editing.description = descriptionController.text;
            todoController.todoList[index] = editing;
          }
          //Navigate BAck after creating/changing
          Get.back();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: "What's on your mind",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
                style: TextStyle(
                  fontSize: 25.0,
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(descriptionNode);
                },
                keyboardType: TextInputType.text,
                maxLines: 2,
                minLines: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TextField(
                  focusNode: descriptionNode,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: "Wanna add more details?",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 999,
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
