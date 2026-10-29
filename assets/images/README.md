# Lecture 14 - 04 - Flutter Web

## Building your project for web
```bash
flutter build web --release
```

This command will prepare your web application and place the files in `/build/web`. After this step we can set up hosting for firebase.

> Important: If you try the below before compiling for web and without `/build/web` existing, you'll get an error


## Deploying to Web
First prepare `hosting` for your project
```bash
firebase init
```
<img src="assets/images/firebase_init_1.png" alt="Firebase Init" width="600">

After selecting `Hosting` we are asked to choose a project:

<img src="assets/images/firebase_init_2.png" alt="Firebase Init" width="600">

Highlight the project you want to select:

<img src="assets/images/firebase_init_3.png" alt="Firebase Init" width="600">

For the build directory of the web files for hosting, we override the default `public` and supply `build/web`

<img src="assets/images/firebase_init_4.png" alt="Firebase Init" width="600">

Click `Y` to configure as a single page web app:

<img src="assets/images/firebase_init_5.png" alt="Firebase Init" width="600">

Do not opt for automatic builds and deploys, and do not overwrite the `index.html`

<img src="assets/images/firebase_init_6.png" alt="Firebase Init" width="600">

Agent skills can be clicked `Y`

<img src="assets/images/firebase_init_7.png" alt="Firebase Init" width="600">

## Firebase setup for hosting contained in `firebase.json`

In the `firebase.json` file we now have an entry for `hosting` which sets out the rules for hosting and also the location of the source file directory 

```json
{
  ...
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}

```

## Deploying to Firebase Hosting
To deploy only the hosting files (preferred method as otherwise everything will be deployed like functions, database rules, storage rules, etc.)

```bash
firebase deploy --only hosting
```
<img src="assets/images/firebase_deploy.png" alt="Firebase Init" width="600">

and finally the app can be accessed at `https://csen268-f25.web.app`

<img src="assets/images/web_app.png" alt="Firebase Init" width="600">






