# Lecture 6 - 01

As we start, we have defined a **model** for a `User` class.

## Packages

We add a number of packages to our codebase. 

- Flutter Lorem [flutter_lorem](https://pub.dev/packages/flutter_lorem)
- UUID [uuid](https://pub.dev/packages/uuid)
- Math `dart:math`
- Convert `dart:convert`

The `flutter_lorem` package creates **Lorem Ipsum** text of desired lengths. This is to create random words or texts.

The `uuid` package creates strings that we commonly see as `id`s in databases.

The `dart:math` library which is built into the Dart language is for calculating a random number in selecting a color from a list of colors.

The `dart:convert` library is used to do the conversion to and from **json**.

## User Class

```dart
class User {
  final String firstName;
  ...
  final String uid;

  User({
    required this.firstName,
    ...
    required this.uid,
  });
}
```
We then use the VSCode Extension **Dart Data Class Generator** to generate standard data methods for us such as:
```dart
  User copyWith({
    String? firstName,
    ...
    String? uid,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      ...
      uid: uid ?? this.uid,
    );
  }
```

## Mock Service

It's important for us to be able to mock data in our development. Therefore the `Mock` service is created
```dart 
class Mock {
  static String firstName() {
    return lorem(paragraphs: 1, words: 1).replaceAll(".", "");
  }

  static String lastName() {
    return lorem(paragraphs: 1, words: 1).replaceAll(".", "");
  }

  static String email() {
    return "${firstName()}@${lastName()}.com";
  }

  static String uid() {
    return UuidV4().generate();
  }

  static String imageUrl({String? firstName, String? lastName}) {
    return 'https://placehold.co/600x400/'
        '${colors[math.Random().nextInt(10)]}'
        '/${colors[math.Random().nextInt(10)]}.png';
  }
}
```

## Creating a random mock User

By adding a constructor method to the `User` class we can create a random user:
```dart
  static User createMockUser() {
    return User(
      firstName: Mock.firstName(),
      lastName: Mock.lastName(),
      email: Mock.email(),
      imageUrl: Mock.imageUrl(),
      uid: Mock.uid(),
    );
  }
```

## ListView Example

And finally we use this random User in the `ListView`. Our [listview_example_page.dart](lib/listview_example_page.dart) is now modified to show a number of random users in a `ListTile`.

