import 'package:flutter/material.dart';

class TodoLayout extends StatelessWidget {
  const TodoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Archive'),
        ],
      ),
    );
  }
}
