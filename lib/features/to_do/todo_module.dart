import 'package:flutter/material.dart';
import 'package:todo/features/to_do/todo_controller.dart';
import 'package:todo/features/to_do/todo_view.dart';
import 'package:todo/shared/repositories/todo_repository.dart';

class TodoModule extends StatefulWidget {
  const TodoModule({super.key});

  @override
  State<TodoModule> createState() => _TodoModuleState();
}

class _TodoModuleState extends State<TodoModule> {
  late ITodoRepository repository = TodoRepositoryAPI();
  late TodoController controller = TodoController(repository);

  @override
  void initState() {
    super.initState();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return TodoView(controller: controller);
      },
    );
  }
}
