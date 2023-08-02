import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_category_response.dart';
import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:flutter/material.dart';

class BlogRepository extends NetworkService with BaseHeaders, BaseUrl{
  Future getNewsRepo(context, String categoryId)async{
    try{
      var json = await getRequest("", header, context);
      BlogNewsResponse response = BlogNewsResponse.fromJson(json);
      if (response.responseCode == "00") {
        return json;
      } else {
        return null;
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future getCategoryRepo(context)async{
    try{
      var json = await getRequest(newsCategoryUrl(limit: "20"), header, context);
      BlogCategoryResponse response = BlogCategoryResponse.fromJson(json);
      if(response.responseCode == "00" || response.responseCode == "000"){
        return json;
      }else{
        return null;
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }
}