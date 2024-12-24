class TaskModel {
  final int? id;
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final String date;
  final int isCompleted;
  final int color;

  TaskModel({
    this.id,
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.isCompleted,
    required this.color,
  });
  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['id'],
      title: jsonData['title'],
      note: jsonData['notes'],
      startTime: jsonData['startTime'],
      endTime: jsonData['endTime'],
      date: jsonData['date'],
      isCompleted: jsonData['complete'],
      color: jsonData['color'],
    );
  }
  /* static List<TaskModel> tasksList = [
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
