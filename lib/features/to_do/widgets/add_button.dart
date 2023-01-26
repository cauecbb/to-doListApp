import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 240,
        height: 85,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.brown,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 2, color: Colors.brown),
        ),
        child: const Icon(Icons.add, size: 40, color: Colors.white),
      ),
    );
  }
}
