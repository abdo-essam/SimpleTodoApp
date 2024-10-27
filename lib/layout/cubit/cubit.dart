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
      },
    );
  }

  List<Task> tasks = [];

  void getTasks() {
    database.rawQuery('SELECT * FROM Task').then((rows) {
      for (var row in rows) {
        tasks.add(Task(
            row["id"].toString() as int,
            row["title"].toString(),
            row["time"].toString(),
            row["date"].toString(),
            row["status"].toString()));
      }
      emit(GetTasksState());
    });
  }

  void insertTask(String title, String time, String date, String status) {
    database.insert('Task', {
      'title': title,
      'time': time,
      'date': date,
      'status': status
    }).then((value) {
      print("task  $value successfully inserted");
      emit(InsertTaskState());
      getTasks();
    });
  }
}
