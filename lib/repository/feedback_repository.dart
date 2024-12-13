import 'package:foodreminder/app/network_connectivity.dart';
import 'package:foodreminder/data_source/local_data_source/feedback_data.dart';
import 'package:foodreminder/data_source/remote_data_source/feedback_remote_data_source.dart';
import 'package:foodreminder/model/userfeedbacks.dart';
import 'dart:io';

abstract class FeedbackRepository {
  // Future<List<User>> getUsers();
  Future<int> createFeedback(File? file, UserFeedback feedback);
}

class FeedbackRepositoryImpl extends FeedbackRepository {
  @override
  Future<int> createFeedback(File? file, UserFeedback feedback) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return FeedbackRemoteDataSource().createFeedback(file, feedback);
    } else {
      return FeedbackDataSource().createFeedback(file, feedback);
    }
  }
}
