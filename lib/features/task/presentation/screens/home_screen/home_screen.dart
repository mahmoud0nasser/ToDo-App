import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/common/commons.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/task_state.dart';
import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // date now
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(
                          DateTime.now(),
                        ),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TaskCubit>(context).changeTheme();
                        },
                        icon: Icon(
                          Icons.mode_night,
                          color: BlocProvider.of<TaskCubit>(context).isDark
                              ? AppColors.white
                              : AppColors.background,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  // Today
                  Text(
                    AppStrings.today,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primary,
                    selectedTextColor: Colors.white,
                    dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                    dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                    monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);

                      // New date selected
                      /* setState(() {
                                  _selectedValue = date;
                        }); */
                    },
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  // no Tasks
                  BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                      // TaskModel.tasksList.isEmpty
                      ? Center(
                          child: noTasksWidget(context),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasksList
                                .length,
                            // itemCount: TaskModel.tasksList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.all(24.0),
                                        height: 240.0,
                                        color: AppColors.deepGrey,
                                        child: Column(
                                          children: [
                                            // Task Completed
                                            BlocProvider.of<TaskCubit>(context)
                                                        .tasksList[index]
                                                        .isCompleted ==
                                                    1
                                                ? Container()
                                                : SizedBox(
                                                    height: 48,
                                                    width: double.infinity,
                                                    child: CustomButton(
                                                      text: AppStrings
                                                          .taskCompleted,
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    TaskCubit>(
                                                                context)
                                                            .updateTask(BlocProvider
                                                                    .of<TaskCubit>(
                                                                        context)
                                                                .tasksList[
                                                                    index]
                                                                .id);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 24.0,
                                            ),
                                            // Delete Task
                                            SizedBox(
                                              height: 48,
                                              width: double.infinity,
                                              child: CustomButton(
                                                text: AppStrings.deleteTask,
                                                onPressed: () {
                                                  BlocProvider.of<TaskCubit>(
                                                          context)
                                                      .deleteTask(BlocProvider
                                                              .of<TaskCubit>(
                                                                  context)
                                                          .tasksList[index]
                                                          .id);
                                                  Navigator.pop(context);
                                                },
                                                backgroundColor: AppColors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24.0,
                                            ),
                                            // Cancel Task
                                            SizedBox(
                                              height: 48,
                                              width: double.infinity,
                                              child: CustomButton(
                                                text: AppStrings.cancel,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: TaskComponent(
                                  taskModel: BlocProvider.of<TaskCubit>(context)
                                      .tasksList[index],
                                  // taskModel: TaskModel.tasksList[index],
                                ),
                              );
                            },
                          ),
                        ),
                  /* InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(24.0),
                                  height: 240.0,
                                  color: AppColors.deepGrey,
                                  child: Column(
                                    children: [
                                      // Task Completed
                                      SizedBox(
                                        height: 48,
                                        width: double.infinity,
                                        child: CustomButton(
                                          text: AppStrings.taskCompleted,
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24.0,
                                      ),
                                      // Delete Task
                                      SizedBox(
                                        height: 48,
                                        width: double.infinity,
                                        child: CustomButton(
                                          text: AppStrings.deleteTask,
                                          onPressed: () {},
                                          backgroundColor: AppColors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24.0,
                                      ),
                                      // Cancel Task
                                      SizedBox(
                                        height: 48,
                                        width: double.infinity,
                                        child: CustomButton(
                                          text: AppStrings.cancel,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: TaskComponent(
                            taskModel: TaskModel.tasksList[0],
                          ),
                        ), */
                ],
              );
            },
          ),
        ),
        // fab
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(
              context: context,
              screen: AddTaskScreen(),
            );
          },
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Column noTasksWidget(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.noTasks,
        ),
        Text(
          AppStrings.noTaskTitle,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 24.0,
              ),
        ),
        Text(
          AppStrings.noTaskSubTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        bottom: 16.0,
      ),
      height: 128.0,
      decoration: BoxDecoration(
        color: getColor(taskModel.color),
        // color: AppColors.red,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: [
          // Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  taskModel.title,
                  // 'Task 1',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 8.0,
                ),
                // row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${taskModel.startTime} - ${taskModel.endTime}',
                      // '09:33 PM - 09:48 PM',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                // note
                Text(
                  taskModel.note,
                  // 'Learn Dart',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: 75.0,
            color: AppColors.white,
            margin: EdgeInsets.only(
              right: 10.0,
            ),
          ),
          /* SizedBox(
            width: 10.0,
          ), */
          // Text
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              taskModel.isCompleted == 1
                  ? AppStrings.completed
                  : AppStrings.toDo,
              // AppStrings.toDo,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
