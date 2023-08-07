import 'package:birds_learning_network/src/features/modules/subscription/model/response_model/subscription_type.dart';

DurationData getSubscriptionPlan(String selectedValue, List<DurationData> plans){
  for(DurationData plan in plans){
    if(plan.duration?.toLowerCase() == selectedValue.toLowerCase()){
      return plan;
    }
  }
  return DurationData();
}