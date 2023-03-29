import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  void urlLauncher(url, context) async {
    Uri url_ = Uri.parse(url);
    if (await canLaunchUrl(url_)) {
      await launchUrl(url_);
    } else {
      showSnack(context, "02", "Unable to launch Page");
    }
  }

  void emailLaunchPage(mail, context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      showSnack(context, "02", "Unable to launch Page");
    }
  }

  void phoneLaunchPage(number, context) async {
    final Uri phoneLauncher = Uri(
      scheme: "tel",
      path: number,
    );
    if (await canLaunchUrl(phoneLauncher)) {
      await launchUrl(phoneLauncher);
    } else {
      showSnack(context, "02", "Unable to launch Page");
    }
  }
}
