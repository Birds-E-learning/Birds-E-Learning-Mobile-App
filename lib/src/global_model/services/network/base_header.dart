import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';

class BaseHeaders {
  final Map<String, String> header = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<Map<String, String>> authHeader() async {
    String auth = await UserSecureStorage().getToken();
    print("auth=====================>>>> $auth");
    return {
      "accept": "application/json",
      "Content-Type": "application/JSON",
      "Authorization": "Bearer $auth",
    };
  }
}
