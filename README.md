# Lecture 16 - 2 SQFLite Local Database

We start by adding the package `sqflite` to our `pubspec.yaml`:
```zsh
flutter pub add sqflite
```

## Test database

To demonstrate the usage of the `sqflite` database we create a `users` table where we save and retrieve `User` objects with the definition of the `User` model:
```dart
class User {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String uid;
  ...
}
```

The `LocalDatabasePage` stateful widget is where we demonstrate basic database functionality.

## Creating the database
In the `initState()` we get a handle on the database. It also includes a mechanism to create the tables within the database on first use but not on subsequent uses:
```dart
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDatabase();
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
```

Note that we don't turn our `initState` into an `async` function. Instead we call `initiDatabase()` **unawaited**. Also, as `uid` is unique, we can ensure that the selection of `uid` as **primary key** will  not cause us problems.

## Getting initial data
To retrieve initial data we call `updateUsers()`.
```dart
  Future<void> updateUsers() async {
    var val = await database.query("users");
    users = val.map((e) => User.fromMap(e)).toList();
    setState(() {});
  }
```

## Adding data
In the button on the page we add the insert functionality:
```dart
  FilledButton(
    child: Text("Insert"),
    onPressed: () async {
      await database.insert("users", User.createMockUser().toMap());
      await updateUsers();
    },
  ),
```

## Deleting Data
As we display the user as a `UserListTile`, the `trailing` widget is a **delete** button as seen in the user list insertion into the column:
```dart
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
```
where we call the `deleteUser()` method
```dart
  Future<void> deleteUser(String uid) async {
    await database.delete("users", where: "uid = ?", whereArgs: [uid]);
  }
```