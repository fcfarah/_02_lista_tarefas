import 'package:_02_lista_tarefas/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
  });

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              // flex: 2,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (_) => onDelete(todo),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MMM/yyyy - HH:mm').format(todo.dateTime),
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
