import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = [];

  HomePage() {
    items = [];
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskController = TextEditingController();

  void add() {
    setState(() {
      if (newTaskController.text.isEmpty) return;
      widget.items.add(
        Item(
          title: newTaskController.text,
          done: false,
        ),
      );
      newTaskController.text = "";
      save();
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data') ?? '';

    Iterable decoded = jsonDecode(data);
    List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
    setState(() {
      widget.items = result;
    });
  }

  _HomePageState() {
    load();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskController,
          keyboardType: TextInputType.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: const InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];

          return Dismissible(
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.5),
            ),
            onDismissed: (direction) {
              remove(index);
            },
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                  save();
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );
  }
}
