# Calculator App

This calculator app is structured using a modular Flutter architecture.
The goal is to separate user interface from app logic. I decided to keep main.dart simple and only start the app.

Then app.dart creates our app, sets up logic for the theme, owns theme state, and returns Material App with the calculators main screen.

After that, each file has a specific role within the application and communicates with other components through inputs and callbacks.
