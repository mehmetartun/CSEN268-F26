import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqflite;

import '../model/user.dart';
import '../widgets/user_list_tile.dart';

class LocalDatabasePage extends StatefulWidget {
  const LocalDatabasePage({super.key});

  @override
  State<LocalDatabasePage> createState() => _LocalDatabasePageState();
}

class _LocalDatabasePageState extends State<LocalDatabasePage> {
  late sqflite.Database database;
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!kIsWeb) {
      initDatabase();
    }
  }

  Future<void> updateUsers() async {
    var val = await database.query("users");
    users = val.map((e) => User.fromMap(e)).toList();
    setState(() {});
  }

  Future<void> initDatabase() async {
    database = await sqflite.openDatabase(
      p.join(await sqflite.getDatabasesPath(), "user_database.db"),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(uid TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, imageUrl TEXT)',
        );
      },
      version: 1,
    );
    updateUsers();
  }

  Future<void> deleteUser(String uid) async {
    await database.delete("users", where: "uid = ?", whereArgs: [uid]);
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: Text("Local Database"), centerTitle: true),
        body: Center(child: Text("Local Database is Not Implemented for WEB")),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text("Local Database"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text("Local Database"),
            FilledButton(
              child: Text("Insert"),
              onPressed: () async {
                await database.insert("users", User.createMockUser().toMap());
                await updateUsers();
              },
            ),
            ...users
                .map(
                  (e) => UserListTile(
                    user: e,
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await deleteUser(e.uid);
                        await updateUsers();
                      },
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
