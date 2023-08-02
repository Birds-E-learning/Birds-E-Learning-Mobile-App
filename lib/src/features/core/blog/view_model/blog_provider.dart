import 'package:birds_learning_network/src/features/core/blog/model/repository/new_blog_repo.dart';
import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_category_response.dart';
import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:flutter/material.dart';

class BlogProvider extends BlogRepository with ChangeNotifier{
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
}