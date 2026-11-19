# Lecture 18 - 6 Testing Tap
In this case we try to tap in our user list. We first create a tap behaviour on our widget by modifying `ListTile` in our `UserListTile`.
```dart
    return ListTile(
      leading: UserAvatar(user: user),
      title: Text(displayName),
      subtitle: Text(user.email),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$displayName added.")),
        );
      },
    );
```
Now we `fling` our `ListView` back up and find the first `UserListTile`. This would correspond to user `First0 Last0`. 
```dart
    await tester.fling(find.byType(ListView), Offset(0, 200), 400);
    await tester.pumpAndSettle();
    expect(find.text("First0 Last0"), findsOne);
    await tester.tap(find.byType(UserListTile).first);
    await tester.pumpAndSettle();
    expect(find.text('First0 Last0 added.'), findsOne);
```
In the above we should have `First0 Last0 added.` displayed in the `SnackBar`.

![TapTesting](/assets/images/Testing%20Tap%20Behaviour.gif)

