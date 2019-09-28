import 'package:firebase/firebase.dart';

String formatTime(Duration duration) => duration.toString().split('.').first;

String formatCode(String text) =>
    text.replaceAll('\\n', '\n').replaceAll('\\-n', '\\n');

String getFirstName(User user) => user.displayName.split(' ').first;

DateTime parseDateTime(DateTime value) => value;
