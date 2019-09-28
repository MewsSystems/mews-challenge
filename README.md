## Mews Challenge

This is a source code of a game presented at WebExpo 2019 by Mews. You can play 2 games: design game and developer game.

Design game consists of 20 questions where you're supposed to choose the image with better UI/UX. Each question has 2 possible variants.

Developer game consists of 20 questions related to languages technologies we use at Mews: C#, JavaScript, Dart, Data: 5 questions for each technology. Each question has 4 variants and only one is correct.

In order to play the game you need to log in with Google or Facebook account, and you have only one attempt. The player with the highest number of correct answers wins (or the fastest one, if 2 players have the same amount of correct answers).

### Technology

For the backend we're using Firebase Firestore + Firebase Functions.

Frontend part is written in Dart.

The project contains:

- `functions`: Firebase functions for the backend part.
- `core`: Common code with services and models.
- `app_angular`: Frontend part in AngularDart.
- `app_flutter`: Frontend part in Flutter Web.

### Set up

1. Create a Firebase project.
2. Replace values of `_apiKey` and `_projectId` in [core.dart](core/lib/core.dart) with the corresponding values from Firebase project.
3. Init Firebase project and upload functions.
4. To launch AngularDart project run:
    ```shell script
    cd app_angular
    webdev serve
    
    # Open http://localhost:8080
    ```
5. To launch Flutter Web project ensure that you've followed [these instructions](https://flutter.dev/docs/get-started/web) and run:
    ```shell script
    cd app_flutter
    flutter run -d chrome
    ```

### Roadmap

There are a lot of improvements that can be made:

- [ ] Refactor AngularDart app: extract common styles, add routing.
- [ ] Remove hardcore values for games/results and make it re-usable for different challenges.
- [ ] Add support for displaying right answers.
- [ ] Add admin panel for managing games.
- [ ] Reuse Flutter code to create mobile apps.

Your contribution is most welcome! If you have any ideas or want to participate feel free to create an issue or Pull Request.
