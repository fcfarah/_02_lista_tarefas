import 'package:flutter/material.dart';

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 75, 198, 214),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ));
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todos = [];

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: todoController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adicione uma tarefa',
                      hintText: 'ex.: estudar Flutter'),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  String text = todoController.text;
                  setState(() {
                    todos.add(text);
                  });
                  todoController.clear();
                },
                style: buttonStyle(),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (String todo in todos)
                  ListTile(
                    title: Text(todo),
                    subtitle: const Text('data'),
                    leading: const Icon(Icons.save, size: 30),
                    onTap: () {
                      print('tarefa');
                    },
                  )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(child: Text('...')),
              ElevatedButton(
                onPressed: () {},
                style: buttonStyle(),
                child: const Text('text'),
              )
            ],
          )
        ],
      ),
    )));
  }
}
