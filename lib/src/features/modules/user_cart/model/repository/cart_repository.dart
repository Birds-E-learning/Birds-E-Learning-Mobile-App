import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/general_response.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_all_cart.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';

class CartRepository extends BaseHeaders with NetworkService, BaseUrl {
  Future addToCartService(context, String idd) async {
    int id = int.parse(idd);
    Map<String, String> header_ = await authHeader();
    var json = await postCartRequest("$saveCart$id", header_, context);
    GeneralCartResponse response = GeneralCartResponse.fromJson(json);
    return response;
  }

  Future addToWishlistService(context, String idd) async {
    int id = int.parse(idd);
    Map<String, String> header_ = await authHeader();
    var json = await postCartRequest("$saveWishlist$id", header_, context);
    GeneralCartResponse response = GeneralCartResponse.fromJson(json);
    return response;
  }

  Future deleteCartService(context, String idd) async {
    int id = int.parse(idd);
    Map<String, String> header_ = await authHeader();
    var json = await deleteRequest("$deleteCart$id", header_, context);
    GeneralCartResponse response = GeneralCartResponse.fromJson(json);
    return response;
  }

  Future deleteWishlistService(context, String idd) async {
    int id = int.parse(idd);
    Map<String, String> header_ = await authHeader();
    var json = await deleteRequest("$deleteWishlist$id", header_, context);
    GeneralCartResponse response = GeneralCartResponse.fromJson(json);
    return response;
  }

  Future getCartService(context) async {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(getAllCart, header_, context);
    GetCartResponse response = GetCartResponse.fromJson(json);
    return response;
  }

  Future getWishlistService(context) async {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(getAllWishlist, header_, context);
    GetCartResponse response = GetCartResponse.fromJson(json);
    return response;
  }

  Future getPickedSections(context, String id) async {
    Map<String, String> header_ = await authHeader();
    var json =
        await getRequest("$getSection${int.parse(id)}", header_, context);
    GetCourseSection response = GetCourseSection.fromJson(json);
    return response;
  }
}
