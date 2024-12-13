import 'package:foodreminder/helper/objectbox.dart';
import 'package:foodreminder/state/objectbox_state.dart';
import 'dart:io';
import 'package:foodreminder/model/userfeedbacks.dart';

class FeedbackDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> createFeedback(File? file, UserFeedback feedback) async {
    try {
      return objectBoxInstance.createFeedback(feedback);
    } catch (e) {
      return Future.value(0);
    }
  }
}
