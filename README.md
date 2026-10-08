# Lecture 7 - 01 

We implement a `Form` in the `EmailPasswordView` widget to submit email and password to the `LoginCubit`.

## The Form

The `Form` is accessed by the `key` of the `FormState` with the declaration:
```dart
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
```
With this key we can access the current state of the `Form` with `formKey.currentState` and run `validation` or `save` methods.

## Input controllers
The text inputs for email and password are done via the `TextEditingController()` which are defined:
```dart
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
```
It's important to note that they need to be disposed when the widget is disposed. This is done by providing the `dispose()` override:
```dart
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
```
## Text form fields

The declaration of the form fields is as follows:
  ```dart
      TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(label: Text("Password")),
      onSaved: (val) {
        password = val;
      },
      validator: (val) {
        if (val == null || val.trim() == "") {
          return "Password must not be empty";
        }
        return null;
      },
    ),
  ```
where the `onSaved(val)` and `validator(val)` methods are given. The `validator(val)` returns `null` if validation succeeds or returns a `String` explaining the reason of the failure. 

## Submitting the form

The submission of the form is done as follows:
```dart
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      BlocProvider.of<LoginCubit>(context).login(email: email!, password: password!);
    }
```
First the `Form` is validated, then if that succeeds, the `save` method is called which transfers the values in the controllers to the variables `email` and `password`. Finally these are passed to the `login()` method of the cubit.