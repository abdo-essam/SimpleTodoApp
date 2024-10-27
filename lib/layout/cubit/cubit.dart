import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/layout/cubit/states.dart';
import 'package:todoapp/modules/All_Tasks_Screen.dart';
import 'package:todoapp/modules/Archived_Tasks_Screen.dart';
import 'package:todoapp/modules/Done_Tasks_Screen.dart';

import '../../model/task.dart';

class TodoCubit extends Cubit<AppStates> {
  TodoCubit() : super(InitialState());

  static TodoCubit get(context) => BlocProvider.of(context);
  late Database database;
  int currentIndex = 0;

  List<Widget> appPages = [
    AllTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomBarState());
  }

  void createDatabase() {
    openDatabase("todo.db", version: 1, onCreate: (Database db, int version) {
      print('database created');
      db.execute(
          'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT , date TEXT , status TEXT)');
    }).then(
      (value) {
        emit(OpenDatabaseState());
        database = value;
        getTasks();
      },
    );
  }

  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> archivedTasks = [];

  void getTasks() {
    tasks.clear();
    database.rawQuery('SELECT * FROM Task').then((rows) {
      for (var row in rows) {
        tasks.add({
          'id': row['id'],
          'title': row['title'],
          'time': row['time'],
          'date': row['date'],
         'status': row['status']
        });
      }
      emit(GetTasksState());
    });
  }

  void insertTask(String title, String time, String date, String status) {
    database.insert('Task', {'title': title, 'time': time, 'date': date,'status': status}).then((id) {
      print("task $id inserted successfully");
      emit(InsertTaskState());
      getTasks();
    });
  }

  void deleteTask(task){
    database.delete('Task', where: 'id=?', whereArgs: [task['id'].toString()]).then((value) {
      print("Task ${task['id']} deleted successfully");
      emit(DeleteTaskState());
      getTasks();
    });
  }
}
