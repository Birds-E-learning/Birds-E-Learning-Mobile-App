import 'dart:io';

import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  Future urlLauncher(url, context) async {
    Uri url_ = Uri.parse(url);
    if (await canLaunchUrl(url_)) {
      await launchUrl(url_);
    } else {
      showSnack(context, "02", "Unable to launch Page");
    }
  }

  Future emailLaunchPage(mail, context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
    );
    String url =  'mailto:$mail';
    if (await canLaunchUrl(Platform.isIOS ? Uri.parse(url) : emailLaunchUri)) {
      await launchUrl(Platform.isIOS ? Uri.parse(url) : emailLaunchUri, mode: LaunchMode.externalApplication);
    } else {
      showSnack(context, "02", "Unable to launch Page");
    }
  }

  Future phoneLaunchPage(number, context) async {
    final Uri phoneLauncher = Uri(
      scheme: "tel",
      path: number,
    );
    String url =  'tel://$number';
    if (await canLaunchUrl(Platform.isIOS ? Uri.parse(url) : phoneLauncher)) {
      await launchUrl(Platform.isIOS ? Uri.parse(url) : phoneLauncher, mode: LaunchMode.externalApplication);
    } else {
      showSnack(context, "02", "Unable to launch Page");
    }
  }

  Future openWhatsapp(context,String number) async {
    var whatsapp = number;
    var whatsappURlAndroid =
        "whatsapp://send?phone=$whatsapp&text=Hello Broadmoney Transfer Admin";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=Hello Broadmoney Transfer Admin";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos), mode: LaunchMode.externalApplication);
      } else {
        showSnack(context, "02", "Whatsapp not installed on this device");
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid), mode: LaunchMode.externalApplication);
      } else {
        showSnack(context, "02", "Whatsapp not installed on this device");
      }
    }
  }
}