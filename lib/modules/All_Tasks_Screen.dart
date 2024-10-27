import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/cubit/cubit.dart';
import 'package:todoapp/layout/cubit/states.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder:  ,
            separatorBuilder: (context, index) =>
                Divider(
                  color: Colors.grey[300],
                  thickness: 1.0,
                ),
            itemCount: TodoCubit
                .get(context)
                .tasks
                .length)
      },
    );
  }
}
