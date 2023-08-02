import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_category_response.dart';
import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/features/core/settings/model/response_model/get_preference.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/facilitator_response.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/model/response_model/anon_credentials.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:flutter/cupertino.dart';

class UnregisteredHomeRepository extends NetworkService with BaseHeaders, BaseUrl{

  Future getFacilitatorInfo(context, String id) async {
    try {
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(facilitatorUrl(id), header_, context);
      FacilitatorResponse response = FacilitatorResponse.fromJson(json);
      if (response.responseCode == "00") {
        return json;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getNewsRepo(context, String categoryId)async{
    try{
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest("", header_, context);
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
      }
      return null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future getFilterDataRepo(context) async {
    try{
      Map<String, String> header_ = await anonymousHeader(context);
      var response = await getRequest(getPref, header_, context);
      print("filter details ===>>> $response");
      GetPreferenceModel responseData = GetPreferenceModel.fromJson(response);
      if (responseData.responseCode == "00") {
        return responseData.responseData!;
      }
      return null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future getAnonymousTokenRepo(context)async{
    try{
      var json = await getRequest(anonUserUrl, header, context);
      if(json != null){
        AnonymousCredentialResponse response = AnonymousCredentialResponse.fromJson(json);
        return response;
      }
       return;
    }catch(e){
      return;
    }
  }
}