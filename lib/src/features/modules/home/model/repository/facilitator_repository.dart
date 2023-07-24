import 'package:birds_learning_network/src/features/modules/home/model/response_model/facilitator_response.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';

class FacilitatorRepository extends NetworkService with BaseHeaders, BaseUrl {
  Future getFacilitatorInfo(context, String id) async {
    try {
      Map<String, String> header_ = await authHeader();
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
}
