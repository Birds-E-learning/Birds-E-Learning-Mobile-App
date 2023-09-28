import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/subscription_plan.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/subscription_reminder.dart';
import 'package:flutter/cupertino.dart';

Future<bool> checkActiveSubscription(context)async{
  try{
    SubscriptionModel? subscription = await SubscriptionStorage().getSubscriptionData();
    if(subscription != null){
      if((subscription.status != null  && subscription.status!.toLowerCase() == "active") && checkDateDifference(subscription)){
        showAppropriateDialog(context, subscription.expirationAt ?? "");
        return true;
      }else{
        return false;
      }
    }return false;
  }catch(e){
    debugPrint(e.toString());
    return false;
  }
}

showAppropriateDialog(context, String date)async{
  if(date.isNotEmpty){
    DateTime newDate = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    int dayDifference = newDate.difference(currentDate).inDays;
    DateTime? lastDisplayedDate = await UserPreferences.getReminderDate();
    if(lastDisplayedDate != null ){
      if(lastDisplayedDate.difference(currentDate).inDays > 0  ){
        if(dayDifference > 3 && dayDifference < 10){
          getSubscriptionDialog("$dayDifference day${dayDifference>0 ? 's' : ''}", context, isDays: true);
          await UserPreferences.setReminderDate();
        }else if (dayDifference < 4 && dayDifference >= 0){
          getSubscriptionDialog("$dayDifference day${dayDifference>0 ? 's' : ''}", context);
          await UserPreferences.setReminderDate();
        }
      }
    }else{
      if(dayDifference > 3 && dayDifference < 10){
        getSubscriptionDialog("$dayDifference day${dayDifference>0 ? 's' : ''}", context, isDays: true);
        await UserPreferences.setReminderDate();
      }else if (dayDifference < 4 && dayDifference >= 0){
        getSubscriptionDialog("$dayDifference day${dayDifference>0 ? 's' : ''}", context);
        await UserPreferences.setReminderDate();
      }
    }
    // print("You have $dayDifference days, $hoursDifference hours and $minuteDifference minutes left");
  }
}

bool checkDateDifference(SubscriptionModel subscription){
  DateTime expiryDate = DateTime.parse(subscription.expirationAt ?? "");
  return expiryDate.difference(DateTime.now()).inMinutes > 0;
}