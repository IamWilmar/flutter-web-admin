import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();
  static showSnackbarError(String message) {
    final snackbar = new SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackbar);
  }

  static showSnackbar(String message) {
    final snackbar = new SnackBar(
      backgroundColor: Colors.grey.withOpacity(0.9),
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackbar);
  }

  static showBusyIndicator(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      content: Container(
        width: 100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(context: context, builder: (_) => dialog);
  }
}
