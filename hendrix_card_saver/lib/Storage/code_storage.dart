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
    return {'id': id, 'name': name, 'code': code};
  }

  @override 
  String toString() {
    return 'Code{id: id, name: name, code: code}';
  }

}

class CodeDatabase {
  static Future<Database> getDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), 'code_database.db'),
      onCreate: (db, version) { 
        return db.execute('CREATE TABLE codes(id NTEGER PRIMARY KEY, name TEXT, code STRING)'
        );
      },
      version: 1,
    );
  }

  Future<void> insertCode(CodeStorage code) async {
  final db = await getDatabase();
  await db.insert(
    'codes',
    code.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<CodeStorage>> code() async {
  final db = await getDatabase();
  final List<Map<String, Object?>> codeMaps = await db.query('code');
  return [
    for (final {'id': id as int, 'name': name as String, 'code': code as String}
        in codeMaps)
      CodeStorage(id: id, name: name, code: code),
    ];
  }
  Future<void> updateCode(CodeStorage code) async {
  final db = await getDatabase();
  await db.update(
    'code',
    code.toMap(),
    where: 'id = ?',
    whereArgs: [code.code],
    );
  }
  Future<void> deleteCode(int id) async {
  final db = await getDatabase();
  await db.delete(
    'code',
    where: 'id = ?',
    whereArgs: [id],
   );
  }

}