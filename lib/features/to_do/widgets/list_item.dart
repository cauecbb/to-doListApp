import 'package:flutter/material.dart';
import 'package:todo/shared/models/todo_model.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.onRemoved,
    required this.onChanged,
    required this.item,
  });
  final TodoModel item;
  final Function() onRemoved;
  final Function(bool value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.title),
      background: Container(
        color: Colors.red.withOpacity(0.85),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Text("Delete",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      onDismissed: (direction) {
        onRemoved();
      },
      child: CheckboxListTile(
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        value: item.done,
        onChanged: (value) {
          onChanged(value ?? false);
        },
      ),
    );
  }
}
