import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/database/Cache/cache_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/model/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(
    DateTime.now(),
  );
  String endTime = DateFormat('hh:mm a').format(
    DateTime.now().add(
      Duration(
        minutes: 45,
      ),
    ),
  );
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // get Date From User
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      // initialDatePickerMode: DatePickerMode.day,
      // initialEntryMode: DatePickerEntryMode.inputOnly,
    );
    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSuccessState());
    } else {
      print('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetStartTimeSuccessState());
    } else {
      print('pickedTime == null');
      emit(GetStartTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ),
    );
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      print('pickedTime == null');
      emit(GetEndTimeErrorState());
    }
  }

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  List<TaskModel> tasksList = [];
  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await sl<SqfliteHelper>().insertToDB(
        TaskModel(
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          date: DateFormat.yMd().format(currentDate),
          isCompleted: 0,
          color: currentIndex,
        ),
      );
      getTasks();

      //! to Make Screen Wait 1 Second
      /* await Future.delayed(
        Duration(seconds: 2),
      );
      tasksList.add(
        TaskModel(
          id: '1',
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          date: DateFormat.yMd().format(currentDate),
          isCompleted: false,
          color: currentIndex,
        ),
      ); */
      titleController.clear();
      noteController.clear();
      emit(InsertTaskSuccessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

  //! get Tasks
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(selectedDate),
          )
          .toList();
      emit(GetDateSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }

  //! Update Task
  void updateTask(id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updateDB(id).then((value) {
      emit(UpdateTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSuccessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }

  bool isDark = false;

  void changeTheme() async {
    isDark = !isDark;
    await sl<CacheHelper>().saveData(
      key: 'isDark',
      value: isDark,
    );
    emit(ChangeThemeState());
  }

  void getTheme() async {
    isDark = await sl<CacheHelper>().getData(
      key: 'isDark',
    );
    emit(GetThemeState());
  }

  /* List<TaskModel> tasksList = [
    TaskModel(
      id: '1',
      title: 'Flutter',
      note: 'Learn Dart',
      startTime: '09:33 PM',
      endTime: '09:45 PM',
      isCompleted: false,
      color: 0,
      date: '8/6/2023',
    ),
    TaskModel(
      id: '2',
      title: 'NodeJS',
      note: 'Learn JavaScript',
      startTime: '09:33 PM',
      endTime: '09:45 PM',
      isCompleted: true,
      color: 5,
      date: '8/6/2023',
    ),
    TaskModel(
      id: '3',
      title: 'Football',
      note: 'Playing With Friends',
      startTime: '09:33 PM',
      endTime: '09:45 PM',
      isCompleted: false,
      color: 3,
      date: '8/6/2023',
    ),
    TaskModel(
      id: '4',
      title: 'GYM',
      note: 'Love Gym',
      startTime: '09:33 PM',
      endTime: '09:45 PM',
      isCompleted: true,
      color: 2,
      date: '8/6/2023',
    ),
    TaskModel(
      id: '2',
      title: 'NodeJS',
      note: 'Learn JavaScript',
      startTime: '09:33 PM',
      endTime: '09:45 PM',
      isCompleted: true,
      color: 4,
      date: '8/6/2023',
    ),
  ]; */
}
