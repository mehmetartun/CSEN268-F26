# Lecture 5 - 02

In this part we explore **Layout** widgets in Flutter as well as a basic routing to be able to switch between examples and also the `Drawer` widget for navigation.

## Routing

The most basic routing is as shown here in the definition of the `MaterialApp`:
```dart
MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/columnExamples": (context) => const ColumnExamplesPage(),
        "/listViewExample": (context) => const ListViewExamplePage(),
        // "/centerExample": (context) => const CenterExamplePage(),
        "/singleChildScrollViewExample": (context) =>
            const SingleChildScrollViewExamplePage(),
        "/singleChildScrollViewAndListViewErrorExample": (context) =>
            const SingleChildScrollViewAndListViewErrorExamplePage(),
        "/singleChildScrollViewAndListViewSolutionExample": (context) =>
            const SingleChildScrollViewAndListViewSolutionExamplePage(),
      },
    )
```
You define the `initialRoute` and then a number of routes with the name of the route being the named route such that you can call `Navigator.of(context).pushNamed(<routeName>)` to push a new route on the stack in the `Drawer` which is defined in the `HomePage`:
```dart
Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text(
                'Navigation', style: Theme.of(context).textTheme.headlineMedium,),
            ),
            ListTile(
              title: const Text('Column Examples'),
              onTap: () {
                Navigator.pushNamed(context, '/columnExamples');
              },
            ),
            ...
          ],
        ),
      ),
```

## Column
In the `Column` examples you can see various settings of the `Column` widget.



## SingleChildScrollView
Here we include a `Column` as the child of the `SingleChildScrollView`.
```dart
SingleChildScrollView(
        child: Column(
          children: [
            Tappable(color: Colors.amber),
            ...
            Tappable(color: Colors.grey),
          ],
        ),
      ),
```
Note: In this example keep tapping in one of the `Tappable` objects and make the counter go to 10 to see the width change and see the effect on the display.

## ListView

The `ListView` can be used on it's own as the `body` of a `Scaffold` as shown here:
```dart
ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Tappable(color: Colors.amber),
          ...
          Tappable(color: Colors.grey),
        ],
      ),
```

## Error with SingleChildScrollView and ListView
In the file [single_child_scroll_view_example_page.dart](/lib/pages/single_child_scroll_view_example_page.dart), using the `SingleChildScrollView` with `ListView` in the default setting:
```dart
SingleChildScrollView(
        child: ListView(
          children: [
            Tappable(color: Colors.amber),
            ...
            Tappable(color: Colors.grey),
          ],
        ),
      ),
```
we will get this error:
```zsh
════════ Exception caught by rendering library ═════════════════════════════════
The following assertion was thrown during performResize():
Vertical viewport was given unbounded height.
```
This is because `SingleChildScrollView` allows it's children to have infinite height and `ListView` is trying to fill all the available space.

## Solution to SingleChildScrollView and ListView
The solution is using `shrinkWrap` and `NeverScrollableScrollPhysics()` for scroll behaviour in the `ListView`.
```dart
 SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Tappable(color: Colors.amber),
            ...
            Tappable(color: Colors.grey),
          ],
        ),
      ),
```

