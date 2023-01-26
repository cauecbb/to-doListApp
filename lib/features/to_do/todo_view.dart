import 'package:flutter/material.dart';
import 'package:todo/features/to_do/todo_controller.dart';
import 'package:todo/features/to_do/widgets/add_button.dart';
import 'package:todo/features/to_do/widgets/list_item.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key, required this.controller});

  final TodoController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: TextFormField(
          focusNode: controller.newTaskFocusNode,
          controller: controller.newTaskController,
          keyboardType: TextInputType.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: "Lato Black",
          ),
          decoration: const InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return ListItem(
            item: controller.items[index],
            onRemoved: () => controller.removeItem(index),
            onChanged: (value) => controller.setItemDone(index, value),
          );
        },
      ),
      floatingActionButton: AddButton(
        onTap: () {
          controller.addItem();
          FocusScope.of(context).requestFocus(controller.newTaskFocusNode);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
