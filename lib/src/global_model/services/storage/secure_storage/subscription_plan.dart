import 'dart:convert';

import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SubscriptionStorage{
  final storage = const FlutterSecureStorage();

  final String _subscriptionKey = "subscription";

  Future setSubscriptionData(SubscriptionModel? data)async{
    try{
      if(data != null){
        await storage.write(key: _subscriptionKey, value: jsonEncode(data.toJson()));
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<SubscriptionModel?> getSubscriptionData()async{
    try{
      var data = await storage.read(key: _subscriptionKey);
      return data != null? SubscriptionModel.fromJson(jsonDecode(data)) : null;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }
}