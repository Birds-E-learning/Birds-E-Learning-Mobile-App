import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class SharePlus{
  static final SharePlus instance = SharePlus._init();
  SharePlus._init();

  static FlutterShareMe? _share;

  Future<FlutterShareMe> get shareMe async {
    if (_share != null) return _share!;

    _share = FlutterShareMe();
    return _share!;
  }


   Future shareToFacebook(context, String msg, {String url = ""}) async{
    try{
      final share = await instance.shareMe;
      String? response =  await share.shareToFacebook(url: url, msg: msg); //:
            // await share.shareToSystem(msg: "$msg $url");
      if(!response!.toLowerCase().contains("sucess") && !response.toLowerCase().contains("success")){
        print("is it true ====>>> ${!response.toLowerCase().contains("success")}");
        showSnack(context, "00", response);
      }
      print("response ====<>>>>> $response");
    }catch(e){
      showSnack(context, "03", e.toString());
    }
  }

  // Future shareToInstagram(context, {String url = ""}) async{
  //   try{
  //     final share = await instance.shareMe;
  //     String? response = await share.shareToInstagram(filePath: url, fileType: FileType.image);
  //     if(response!.toLowerCase() != "success"){
  //       showSnack(context, "00", response);
  //     }
  //     print("response ===>> $response");
  //   }catch(e){
  //     showSnack(context, "03", e.toString());
  //   }
  // }

  Future shareToLinkedin(context, String msg, {String url = ""}) async{
    try{
      final share = await instance.shareMe;
      String? response = await share.shareToSystem(msg: "$msg $url");
      if(!response!.toLowerCase().contains("sucess") && !response.toLowerCase().contains("success")){
        showSnack(context, "00", response);
      }
    }catch(e){
      showSnack(context, "03", e.toString());
    }
  }

  Future shareToX(context, String msg, {String url = ""}) async{
    try{
      final share = await instance.shareMe;
      String? response = await share.shareToTwitter(url: url, msg: msg);
      if(!response!.toLowerCase().contains("sucess") && !response.toLowerCase().contains("success")){
        showSnack(context, "00", response);
      }
    }catch(e){
      showSnack(context, "03", e.toString());
    }
  }

  Future shareLink(context, String msg, {String url = ""}) async{
    try{
      final share = await instance.shareMe;
      String? response = await share.shareToSystem(msg: "$msg $url");
      if(!response!.toLowerCase().contains("sucess") && !response.toLowerCase().contains("success")){
        showSnack(context, "00", response);
      }
    }catch(e){
      showSnack(context, "03", e.toString());
    }
  }
}