import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_charges.dart';
import 'package:birds_learning_network/src/features/modules/payment/model/request_model/stripe_model.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';

class PaymentRepository extends NetworkService with BaseUrl, BaseHeaders {
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

  Future generateStripeKeys(context) async {
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(stripeKeys, header_, context);
      return json;
    } catch (e) {
      return null;
    }
  }

  Future makePaymentRepo(context, StripeChargesRequest data) async {
    try {
      Map<String, String> header_ = await authHeader();
      var json =
          await postRequest(stripeCharges, header_, data.toJson(), context);
      return json;
    } catch (e) {
      return null;
    }
  }
}
