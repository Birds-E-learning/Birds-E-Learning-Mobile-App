import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_category_response.dart';
import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/get_preference.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/facilitator_response.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/cart/view/screens/cart_screen.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/screens/course_screen.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/model/repository/home_repository.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/model/response_model/anon_credentials.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/screens/home_page.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/profile/view/screens/profile_screen.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/cupertino.dart';

class UnregisteredHomeProvider extends UnregisteredHomeRepository with ChangeNotifier{
  int _selectedIndex = 0;
   static const List<Widget> _widgetOptions = <Widget>[
     UnregisteredUserHomePage(),
    UnregisteredCartScreen(),
     UnregisteredCourseScreen(),
     UnregisteredProfileScreen()
  ];

  List<Widget> get screens => _widgetOptions;
  int get selectedIndex => _selectedIndex;

  set onItemClick(int index) {
    _selectedIndex = index;
    notifyListeners();
  }


  // Provider FOR FACILITATOR, NEWS $ BLOG

  List _myList = [];

  Status  loadingStatus = Status.initial; // loading status for preference list
  Status facilitatorStatus = Status.initial;

  List get prefList => _myList;

  Future getPreferenceList(context) async {
    try {
      List<String> list = [];
      loadingStatus = Status.loading;
      notifyListeners();
      var prefList_ = await getFilterDataRepo(context);
      if (prefList_ != null && prefList_.isNotEmpty) {
        for (PreferenceResponseData val in prefList_) {
          list.add(val.name!);
        }
        _myList = list;
        notifyListeners();
      }
      loadingStatus = Status.completed;
      notifyListeners();
    } catch (_) {
      loadingStatus = Status.error;
      notifyListeners();
    }
  }

  List<Courses> courseList = [];
  FacilitatorData facilitatorData = FacilitatorData();

  void refreshData() {
    facilitatorStatus = Status.initial;
    facilitatorData = FacilitatorData();
    notifyListeners();
  }

  Future getFacilitatorData(context, String id) async {
    try {
      facilitatorStatus = Status.loading;
      notifyListeners();
      var json = await getFacilitatorInfo(context, id);
      facilitatorStatus = Status.completed;
      notifyListeners();
      if (json != null) {
        FacilitatorResponse response = FacilitatorResponse.fromJson(json);
        facilitatorData = response.responseData ?? FacilitatorData();
        courseList = response.responseData!.courses ?? [];
        notifyListeners();
      } else {
        showSnack(context, "03", "Unable to get Facilitator details");
      }
    } catch (e) {
      facilitatorStatus = Status.error;
      notifyListeners();
      showSnack(context, "04", "Error: ${e.toString()}");
    }
  }

  Status newsStatus = Status.initial;
  Status categoryStatus = Status.initial;
  List<CategoryData> newsCategories = [];
  List<NewsData> news = [];

  Future getNewsCategoryMethod(context)async{
    try{
      categoryStatus = Status.loading;
      notifyListeners();
      BlogCategoryResponse? response = await getCategoryRepo(context);
      categoryStatus = Status.completed;
      notifyListeners();
      if(response!= null){
        newsCategories = response.responseData ?? [];
        notifyListeners();
      }
    }catch(e){
      categoryStatus = Status.error;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  Future getCategoryNewsMethod(context, String categoryId)async{
    try{
      newsStatus = Status.loading;
      notifyListeners();
      BlogNewsResponse? response = await getNewsRepo(context, categoryId);
      newsStatus = Status.completed;
      notifyListeners();
      if(response!= null){
        news = response.responseData ?? [];
        notifyListeners();
      }
    }catch(e){
      newsStatus = Status.error;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  Future getAnonymousToken(context)async{
    try{
        AnonymousCredentialResponse? response = await getAnonymousTokenRepo(context);
        if(response != null && response.responseCode == "00" || response!.responseCode == "000"){
          await UserSecureStorage().setAnonToken(response.responseData!.authToken);
          return response.responseData!.authToken;
        }
    }catch(e){
      debugPrint(e.toString());
    }
  }
}