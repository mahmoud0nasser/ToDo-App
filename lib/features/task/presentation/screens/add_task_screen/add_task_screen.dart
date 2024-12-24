import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/common/commons.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../components/add_task_component.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //! Native
    // print(MediaQuery.of(context).size.height);
    // print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          // child: BlocBuilder<TaskCubit, TaskState>(
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is InsertTaskSuccessState) {
                showToast(
                  message: 'Added Successfully...',
                  state: ToastStates.success,
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<TaskCubit>(context);
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Title
                    AddTaskComponent(
                      controller:
                          BlocProvider.of<TaskCubit>(context).titleController,
                      title: AppStrings.title,
                      hintText: AppStrings.titleHint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.titleErrorMsg;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.0.h,
                    ),
                    //! Note
                    AddTaskComponent(
                      title: AppStrings.note,
                      hintText: AppStrings.noteHint,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.noteErrorMsg;
                        }
                        return null;
                      },
                      controller:
                          BlocProvider.of<TaskCubit>(context).noteController,
                    ),
                    SizedBox(
                      height: 24.0.h,
                    ),
                    //! Date
                    AddTaskComponent(
                      title: AppStrings.date,
                      hintText: DateFormat.yMd().format(
                        // DateTime.now(),
                        // BlocProvider.of<TaskCubit>(context).currentDate,
                        cubit.currentDate,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          cubit.getDate(context);
                          // BlocProvider.of<TaskCubit>(context).getDate(context);
                          /* DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                            // initialDatePickerMode: DatePickerMode.day,
                            // initialEntryMode: DatePickerEntryMode.inputOnly,
                          );
                          setState(() {
                            if (pickedDate != null) {
                              currentDate = pickedDate;
                            } else {
                              print('pickedDate == null');
                            }
                          }); */
                        },
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.white,
                        ),
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 24.0.h,
                    ),
                    //! Start - End Time
                    Row(
                      children: [
                        // start Time
                        Expanded(
                          child: AddTaskComponent(
                            title: AppStrings.startTime,
                            hintText: cubit.startTime,
                            // BlocProvider.of<TaskCubit>(context).startTime,
                            /* hintText: DateFormat('hh:mm a').format(
                                      DateTime.now(),
                                    ), */
                            readOnly: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                cubit.getStartTime(context);
                                /* BlocProvider.of<TaskCubit>(context)
                                    .getStartTime(context); */
                                /* TimeOfDay? pickedStartTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                    DateTime.now(),
                                  ),
                                );
                                setState(() {
                                  if (pickedStartTime != null) {
                                    startTime = pickedStartTime.format(context);
                                  } else {
                                    print('pickedTime == null');
                                  }
                                }); */
                              },
                              icon: Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 26.0.h,
                        ),
                        //! End
                        Expanded(
                          child: AddTaskComponent(
                            title: AppStrings.endTime,
                            hintText: cubit.endTime,
                            // BlocProvider.of<TaskCubit>(context).endTime,
                            /* hintText: DateFormat('hh:mm a').format(
                                      DateTime.now(),
                                    ), */
                            readOnly: true,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                cubit.getEndTime(context);
                                /* BlocProvider.of<TaskCubit>(context)
                                    .getEndTime(context); */
                                /* TimeOfDay? pickedEndTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                    DateTime.now(),
                                  ),
                                );
                                setState(() {
                                  if (pickedEndTime != null) {
                                    endTime = pickedEndTime.format(context);
                                  } else {
                                    print('pickedTime == null');
                                  }
                                }); */
                              },
                              icon: Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0.h,
                    ),
                    //! Color
                    SizedBox(
                      height: 68.0.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // color
                          Text(
                            AppStrings.color,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 8.0.w,
                              ),
                              itemBuilder: (context, index) {
                                /* Color getColor(index) {
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
                                } */

                                return GestureDetector(
                                  onTap: () {
                                    /* setState(() {
                                      currentIndex = index;
                                    }); */
                                    cubit.changeCheckMarkIndex(index);
                                    /* BlocProvider.of<TaskCubit>(context)
                                        .changeCheckMarkIndex(index); */
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: cubit.getColor(index),
                                    /* BlocProvider.of<TaskCubit>(context)
                                            .getColor(index), */
                                    child: index ==
                                            /* BlocProvider.of<TaskCubit>(context)
                                                .currentIndex */
                                            cubit.currentIndex
                                        ? Icon(
                                            Icons.check,
                                          )
                                        : null,
                                  ),
                                );
                              },
                              itemCount: 6,
                            ),
                          ),
                          /* Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.red,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: AppColors.red,
                                      ),
                                    ],
                                  ), */
                        ],
                      ),
                    ),
                    //! Add Task Button
                    // Spacer(),
                    SizedBox(
                      height: 90.0.h,
                      // height: 182.0.h,
                    ),
                    state is InsertTaskLoadingState
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : SizedBox(
                            height: 48.h,
                            width: double.infinity,
                            child: CustomButton(
                              text: AppStrings.createTask,
                              onPressed: () {
                                if (BlocProvider.of<TaskCubit>(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  BlocProvider.of<TaskCubit>(context)
                                      .insertTask();
                                }
                              },
                            ),
                          ),
                    /* Text(
                              AppStrings.note,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              controller: noteController,
                              decoration: InputDecoration(
                                // Hint
                                hintText: AppStrings.noteHint,
                              ),
                            ), */
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
