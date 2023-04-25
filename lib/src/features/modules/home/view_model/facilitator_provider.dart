import 'package:birds_learning_network/src/features/modules/home/model/repository/facilitator_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/facilitator_response.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class FacilitatorProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<FacilitatorCourses> courseList = [];
  String name = "";
  String email = "";
  String aboutMe = "";
  String rating = "";
  String studentNo = "";

  bool get isLoading => _isLoading;

  Future getFacilitatorData(context, String id) async {
    try {
      _isLoading = true;
      var json = await FacilitatorRepository().getFacilitatorInfo(context, id);
      if (json != null) {
        FacilitatorResponse response = FacilitatorResponse.fromJson(json);
        name =
            "${response.responseData!.firstName} ${response.responseData!.lastName}";
        aboutMe = response.responseData!.aboutMe!;
        rating = response.responseData!.averageRating!.toString();
        studentNo = response.responseData!.numberOfStudents!.toString();
        courseList = response.responseData!.courses!;
        notifyListeners();
        _isLoading = false;
      } else {
        _isLoading = false;
        showSnack(context, "03", "Unable to get Facilitator details");
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnack(context, "04", "Error in connectin... Try again Later");
    }
  }
}
