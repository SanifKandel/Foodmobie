//Create a class for the dialog
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class FeedbackDialog {
  static void show(BuildContext context) {
    Dialogs.bottomMaterialDialog(
      msg:
          'Experienced an issue? Tap the button below to send us a report. Your feedback helps us improve FoodMobie.',
      title: 'Feedback',
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
// Navigator.of(context).pop();
          },
          text: 'Give a Feedback',
          iconData: Icons.feedback,
          color: Colors.teal,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
