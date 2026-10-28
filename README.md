### Lecture 13 - 03 Implementing Future Builder, Shimmer, Stream Builder


### Step 3 - Implement Shimmer
In the previous step we implemented the `StreamBuilder` to bring the content from the database. Shimmer allows you to display placeholders to prepare the user about the type of data the page is going to receive rather than showing a generic spinner.

#### Add shimmer package
We start by adding the package
```zsh
flutter pub add shimmer
```
#### Building a widget with Shimmer
The Future returns mock users as `ListTile` and we simply build our shimmer widget using `Container` widgets.

```dart
class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: List.generate(10, (index) {
          return Container(
            height: 50,

            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
```
#### Using the ShimmerListWidget

We inject the widget in the `FutureBuilder`:
```dart
    FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
            return Column(
            mainAxisSize: MainAxisSize.min,
            children: snapshot.data!.map((user) {
                return UserListTile(user: user);
            }).toList(),
            );
        } else {
            return ShimmerListWidget();
        }
        },
    ),
```

Finally, we will see the following when the `Future` is loading:

![Shimmer Demo](/assets/gifs/ShimmerDemo.gif)

