import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_category_response.dart';
import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:flutter/material.dart';

class UnregisteredBlogRepository extends NetworkService with BaseHeaders, BaseUrl{
  Future getNewsRepo(context, String categoryId)async{
    try{
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(newsUrl(categoryId), header_, context);
      print("json ====>>>> $json");
      BlogNewsResponse response = BlogNewsResponse.fromJson(json);
      if (response.responseCode == "00") {
        return response;
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
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(newsCategoryUrl(limit: "20"), header_, context);
      BlogCategoryResponse response = BlogCategoryResponse.fromJson(json);
      if(response.responseCode == "00" || response.responseCode == "000"){
        return response;
      }else{
        return null;
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }
}