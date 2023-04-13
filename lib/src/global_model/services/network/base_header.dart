import 'package:birds_learning_network/src/features/modules/payment/view_model/payment_provider.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class BaseHeaders {
  final Map<String, String> header = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<Map<String, String>> authHeader() async {
    String auth = await UserSecureStorage().getToken();
    return {
      "accept": "application/json",
      "Content-Type": "application/JSON",
      "Authorization": "Bearer $auth",
    };
  }

  Future<Map<String, String>> stripeHeader(context) async {
    String key = await Provider.of<PaymentProvider>(context, listen: false)
        .getStripeKeys(context, keyToGet: "secret");
    return {
      'Authorization': 'Bearer $key',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }
}
