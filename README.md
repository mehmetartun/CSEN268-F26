# Lecture 18 - 2  Flutter Testing


# Step 02 - Testing a Cubit
Now we will create a cubit and test the cubit.
```dart
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
  int counter = 0;

  void add() {
    counter += 1;
  }

  void subtract() {
    counter -= 1;
  }
}
```
We will test whether the `add()` and `subtract()` methods of the counter are working.

### Writing the test
We can create a separate file `test.dart` where we test objects.
```dart
void main() {
  CounterCubit cubit = CounterCubit();
  test("Counter Cubit Test", () {
    cubit.add();
    expect(cubit.counter, 1);
    cubit.subtract();
    expect(cubit.counter, 0);
  });
}
```
we can run the test and receive the following result:
```zsh
flutter test test/test.dart
00:01 +1: All tests passed!     
```

### Simulate fail
If we change our test to:
```dart
void main() {
  CounterCubit cubit = CounterCubit();
  test("Counter Cubit Test", () {
    cubit.add();
    expect(cubit.counter, 1);
    cubit.subtract();
    expect(cubit.counter, 1);
  });
}
```
There the second expect would result in error, we get the following result:
