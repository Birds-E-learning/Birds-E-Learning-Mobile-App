import 'package:birds_learning_network/src/features/modules/home/model/repository/facilitator_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/facilitator_response.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class FacilitatorProvider extends ChangeNotifier {
  Status loadingStatus = Status.initial;
  List<Courses> courseList = [];
  FacilitatorData? facilitator;

  void refreshData() {
    facilitator = null;
    courseList = [];
    notifyListeners();
  }

  void setLoadingStatus({Status status = Status.initial}){
    loadingStatus = status;
    notifyListeners();
  }

  Future getFacilitatorData(context, String id) async {
    try {
      setLoadingStatus(status: Status.loading);
      var json = await FacilitatorRepository().getFacilitatorInfo(context, id);
      setLoadingStatus(status: Status.completed);
      if (json != null) {
        FacilitatorResponse response = FacilitatorResponse.fromJson(json);
        facilitator = response.responseData;
        courseList = response.responseData!.courses!;
        notifyListeners();
      } else {
        showSnack(context, "03", "Unable to get Facilitator details");
      }
    } catch (e) {
      setLoadingStatus(status: Status.error);
    }
  }
}
