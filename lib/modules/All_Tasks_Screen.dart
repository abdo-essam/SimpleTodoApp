import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/cubit/cubit.dart';
import 'package:todoapp/layout/cubit/states.dart';
import 'package:todoapp/model/task.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(TodoCubit.get(context).tasks[index], context),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  thickness: 1.0,
                ),
            itemCount: TodoCubit.get(context).tasks.length);
      },
    );
  }
}

Widget buildTaskItem(task, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            task['title'],
            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(task['time']),
              const SizedBox(width: 8),
              Text(task['date']),
            ],
          )
        ],
      ),
      Row(
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.archive),
              color: Colors.grey,
              onPressed: () => {}),
          IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => {
                TodoCubit.get(context).deleteTask(task)
              }),
        ],
      ),
    ]),
  );
}
