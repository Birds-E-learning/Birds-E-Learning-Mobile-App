import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_model.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/request_model/subscribe_model.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscribe_response.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscription_latest.dart';
import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscription_type.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/subscription_plan.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/cupertino.dart';

class SubscriptionRepo extends NetworkService with BaseUrl, BaseHeaders{

  Future getSubscriptionPlansRepo(context)async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(subscriptionPlanUrl, header_, context);
      if(json != null){
        SubscriptionDurationModel response = SubscriptionDurationModel.fromJson(json);
        if(response.responseCode == "00" || response.responseCode == "000"){
          return response.responseData;
        }else{
          showSnack(context, response.responseCode!, response.responseMessage ?? "");
        }
      }
      return null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future getLatestSubscriptionRepo(context) async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(subscriptionLatestUrl, header_, context);
      if(json != null){
        SubscriptionLatestResponse response = SubscriptionLatestResponse.fromJson(json);
        if(response.responseCode == "00" || response.responseCode == "000"){
          await SubscriptionStorage().setSubscriptionData(response.responseData);
          return response.responseData;
        }
      }
      return null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future subscriptionPaymentRepo(context, SubscriptionPaymentRequest data) async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await postRequest(subscriptionPaymentUrl, header_, data.toJson(), context);
      print("json ===> $json");
      if(json != null){
        SubscriptionPaymentResponse response = SubscriptionPaymentResponse.fromJson(json);
        return response;
      }
      return null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future stripePaymentIntent(StripePaymentModel body, context) async {
    try {
      Map<String, String> header_ = await stripeHeader(context);
      var response =
      await stripeRequest(stripePayment, header_, context, body.toJson());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}