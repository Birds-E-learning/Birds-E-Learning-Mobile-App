import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload {
  XFile? pickedImg_;
  final ImagePicker _picker = ImagePicker();

  void _pickImg(
      ImageSource src, void Function(XFile pickedImg) imgPickFn) async {
    final pickedImgFile =
        await _picker.pickImage(source: src, imageQuality: 50);
    if (pickedImgFile != null) {
      pickedImg_ = XFile(pickedImgFile.path);
      imgPickFn(XFile(pickedImgFile.path));
    }
  }

  uploadImage(context, void Function(XFile pickedImg) imgPickFn) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SelectOptions(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImg(ImageSource.camera, imgPickFn);
                    },
                    icon: const Icon(Icons.photo_camera_outlined, color: black),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add image from Camera',
                        style: TextStyle(
                          color: success1000,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImg(ImageSource.gallery, imgPickFn);
                    },
                    icon: const Icon(Icons.image_rounded, color: black),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add image from Gallery',
                        style: TextStyle(
                          color: success1000,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}

class SelectOptions extends StatelessWidget {
  const SelectOptions({Key? key, @required this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        height: 130,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: child,
      ),
    );
  }
}
