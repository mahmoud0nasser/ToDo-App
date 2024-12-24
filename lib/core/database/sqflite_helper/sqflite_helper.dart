import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';

class SqfliteHelper {
  late Database db;
  // 1.Create Database
  // 2.Create Table
  // 3.CRUD => Create - Read - Update - Delete

  //! initDatabase
  void initDB() async {
    // step 1 => Create Database
    await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int v) async {
        // step 2 => Create Table
        await db.execute('''
          CREATE TABLE Tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            notes TEXT,
            date TEXT,
            startTime TEXT,
            endTime TEXT,
            color INTEGER,
            complete INTEGER
          )
        ''').then(
          (value) => print('DB Created Successfully...'),
        );
      },
      onOpen: (db) => print('Database Opened...'),
    ).then((value) => db = value).catchError((e) {
      print(e.toString());
    });
  }

  //! get
  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery(
      'SELECT * FROM Tasks',
    );
  }

  //! Insert
  Future<int> insertToDB(TaskModel model) async {
    return await db.rawInsert(
      '''
        INSERT INTO Tasks(
        title, notes, date, startTime, endTime, color, complete) VALUES('${model.title}', '${model.note}', '${model.date}', '${model.startTime}', '${model.endTime}', '${model.color}', '${model.isCompleted}')''',
    );
  }
  //! update

  Future<int> updateDB(int id) async {
    return await db.rawUpdate(
      '''
          UPDATE Tasks
          SET complete = ?
          WHERE id = ?
      ''',
      [1, id],
    );
  }

  //! delete
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete(
      '''DELETE FROM Tasks WHERE id = ?''',
      [id],
    );
  }
}
