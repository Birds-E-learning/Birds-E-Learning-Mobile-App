import 'package:birds_learning_network/src/features/modules/home/model/repository/facilitator_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/facilitator_response.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class FacilitatorProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Courses> courseList = [];
  String name = "";
  int totalCourse = 0;
  String imageUrl = "";
  String email = "";
  String aboutMe =
      "Lorem ipsum dolor sit amet consectetur. Pharetra odio at cursus nulla suspendisse vitae sit nibh. Magnis pharetra nisi nibh ornare magna potenti fames dictum. Id mauris ullamcorper cursus et ullamcorper pharetra eget ornare. Sed vitae velit consectetur tristique pellentesque quam condimentum lacus dui. Leo ut nunc sit lectus dolor volutpat leo.";
  String rating = "";
  String studentNo = "";

  bool get isLoading => _isLoading;

  void refreshData() {
    _isLoading = false;
    courseList = [];
    name = "";
    totalCourse = 0;
    imageUrl = "";
    email = "";
    aboutMe = "";
    rating = "";
    studentNo = "";
    notifyListeners();
  }

  Future getFacilitatorData(context, String id) async {
    try {
      _isLoading = true;
      var json = await FacilitatorRepository().getFacilitatorInfo(context, id);
      if (json != null) {
        FacilitatorResponse response = FacilitatorResponse.fromJson(json);
        name =
            "${response.responseData!.firstName} ${response.responseData!.lastName}";
        aboutMe = response.responseData!.aboutMe!;
        imageUrl = response.responseData!.imageUrl!;
        rating = response.responseData!.averageRating!.toString();
        totalCourse = response.responseData!.numberOfCourses ?? 0;
        email = response.responseData!.emailAddress ?? "";
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
