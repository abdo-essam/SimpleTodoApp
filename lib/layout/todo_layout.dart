import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/cubit/states.dart';

import 'cubit/cubit.dart';

class TodoLayout extends StatelessWidget {
  const TodoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('To-Do List'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                TodoCubit.get(context)
                    .insertTask("PLAY GAMES", "10:00 AM", "10/10/2021", "New");
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: TodoCubit.get(context).currentIndex,
              onTap: (index) {
                TodoCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archive'),
              ],
            ),
            body: TodoCubit.get(context)
                .appPages[TodoCubit.get(context).currentIndex],
          );
        },
      ),
    );
  }
}
