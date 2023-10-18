import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_review.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/model/repository/course_repo.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:flutter/material.dart';

class UnregisteredCourseContentProvider extends UnregisteredCourseRepo with  ChangeNotifier {
  bool showBackToTop = false;
  bool _isYoutube = false;
  bool _isVideo = false;
  bool _showVideo = false;
  String url = "https://www.youtube.com/watch?v=tO01J-M3g0U";
  List<bool> selectedLesson = [];
  bool _sectionLoading = false;
  Status reviewStatus = Status.initial;
  bool reviewClicked = false;
  List<Reviews> reviews = [];
  dynamic reviewers = 0;
  // bool onLessonSelected = false;

  bool get isYoutube => _isYoutube;
  bool get isVideo => _isVideo;
  bool get showVideo => _showVideo;
  bool get sectionLoading => _sectionLoading;

  void onPreviewClick(bool value) {
    _showVideo = value;
    notifyListeners();
  }

  void youtubeVid( bool value){
    _isYoutube = value;
    notifyListeners();
  }

  void video( bool value){
    _showVideo = value;
    notifyListeners();
  }

  void onLimitExceeded(bool value) {
    showBackToTop = value;
    notifyListeners();
  }

  void onReviewClicked(){
    reviewClicked = !reviewClicked;
    notifyListeners();
  }

  void setReviewStatus({Status status = Status.initial}){
    reviewStatus = status;
    notifyListeners();
  }

  void setSelectedLesson(int index) {
    selectedLesson[index] = !selectedLesson[index];
    notifyListeners();
  }

  void updateVideoUrl(String vid) {
    url = vid;
    notifyListeners();
  }

  void reset() {
    _isYoutube = false;
    _isVideo = false;
    _showVideo = false;
    selectedLesson = [];
    notifyListeners();
  }

  Future<List<Sections>> getCourseSection(context, String id) async {
    try {
      _sectionLoading = true;
      notifyListeners();
      GetCourseSection response = await getPickedSections(context, id);
      _sectionLoading = false;
      notifyListeners();
      if (response.responseCode == "00") {
        return response.responseData!;
      } else {
        return [];
      }
    } catch (e) {
      _sectionLoading = false;
      notifyListeners();
      return [];
    }
  }

  Future getReviewMethod(context, String id)async{
    try{
      setReviewStatus(status: Status.loading);
      GetReviewResponse? response = await getReviewRepo(context, id);
      setReviewStatus(status: Status.completed);
      if(response != null){
        reviews = response.responseData?.reviews ?? [];
        reviewers = response.responseData?.totalReviewers ?? 0;
        notifyListeners();
      }
    }catch(e){
      setReviewStatus(status: Status.error);
      return;
    }
  }
}
