import 'package:flutter/material.dart';

class CourseContentProvider extends ChangeNotifier {
  bool showBackToTop = false;
  bool _isYoutube = false;
  bool _isVideo = false;
  bool _showVideo = false;
  String url = "https://www.youtube.com/watch?v=tO01J-M3g0U";
  List<bool> selectedLesson = [];
  bool onLessonSelected = false;

  bool get isYoutube => _isYoutube;
  bool get isVideo => _isVideo;
  bool get showVideo => _showVideo;

  set youtubeVid(value) => _isYoutube = value;
  set video(value) => _isVideo = value;

  void onPreviewClick() {
    _showVideo = !_showVideo;
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
    notifyListeners();
  }
}
