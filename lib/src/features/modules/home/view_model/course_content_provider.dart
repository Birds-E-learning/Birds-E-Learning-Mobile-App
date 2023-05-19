import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/repository/cart_repository.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:flutter/material.dart';

class CourseContentProvider extends ChangeNotifier {
  CartRepository repo = CartRepository();
  bool showBackToTop = false;
  bool _isYoutube = false;
  bool _isVideo = false;
  bool _showVideo = false;
  String url = "https://www.youtube.com/watch?v=tO01J-M3g0U";
  List<bool> selectedLesson = [];
  bool _sectionLoading = false;
  // bool onLessonSelected = false;

  bool get isYoutube => _isYoutube;
  bool get isVideo => _isVideo;
  bool get showVideo => _showVideo;
  bool get sectionLoading => _sectionLoading;

  set youtubeVid(value) => _isYoutube = value;
  set video(value) => _isVideo = value;

  void onPreviewClick(bool value) {
    _showVideo = value;
    notifyListeners();
  }

  void onLimitExceeded(bool value) {
    showBackToTop = value;
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
      GetCourseSection response = await repo.getPickedSections(context, id);
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
}
