import 'package:_02_lista_tarefas/models/todo.dart';
import 'package:_02_lista_tarefas/repositories/todo_repository.dart';
import 'package:_02_lista_tarefas/widgets/todo_list_item.dart';
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
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];

  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      Todo newTodo = Todo(
                        title: text,
                        dateTime: DateTime.now(),
                      );
                      todos.add(newTodo);
                    });
                    todoController.clear();
                    todoRepository.saveTodoList(todos);
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
                  for (Todo todo in todos)
                    TodoListItem(
                      todo: todo,
                      onDelete: onDelete,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Você possui ${todos.length} tarefas pendentes',
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: showDeleteTodosConfirmationDialog,
                  style: buttonStyle(),
                  child: const Text('Limpar tudo'),
                )
              ],
            )
          ],
        ),
      ))),
    );
  }

  void onDelete(Todo todo) {
    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('tarefa ${todo.title} removida com sucesso!'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () => setState(() => todos.add(todo)),
      ),
      duration: const Duration(seconds: 5),
    )); // todos.remove(todo);
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content:
            const Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 67, 54, 244)),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => setState(() => todos = []),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Limpar tudo'),
          ),
        ],
      ),
    );
  }
}
