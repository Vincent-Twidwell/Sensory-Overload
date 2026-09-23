import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CodeStorage {
  final String name;
  final int id;
  final String code;
  
  CodeStorage({required this.code, required this.id, required this.name});

  Map<String, Object?> toMap() {
    return {'code': code, 'id': id, 'name': name};
  }

  @override 
  String toString() {
    return 'Code{code: code}';
  }

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'code_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE codes(id INTEGER PRIMARY KEY, name TEXT, code STRING)',
      );
    },
    version: 1,
  );
  Future<void> insertDog(CodeStorage code) async {
  final db = await database;
  await db.insert(
    'code',
    code.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<CodeStorage>> code() async {
  final db = await database;
  final List<Map<String, Object?>> codeMaps = await db.query('code');
  return [
    for (final {'id': id as int, 'name': name as String, 'code': code as String}
        in codeMaps)
      CodeStorage(id: id, name: name, code: code),
    ];
  }
  Future<void> updateCode(CodeStorage code) async {
  final db = await database;
  await db.update(
    'code',
    code.toMap(),
    where: 'id = ?',
    whereArgs: [code.code],
    );
  }
  Future<void> deleteCode(int id) async {
  final db = await database;
  await db.delete(
    'code',
    where: 'id = ?',
    whereArgs: [id],
   );
  }

}