import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class PreviewContainer extends StatelessWidget {
  const PreviewContainer({
    super.key,
    required this.image,
    this.onTap,
    this.loaded = true,
  });
  final dynamic image;
  final VoidCallback? onTap;
  final bool loaded;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
              image: DecorationImage(
                  image: image.toString().contains(".com")
                      ? Image.network(
                          image.toString(),
                        ).image
                      : Image.asset(
                          ImagePath.thumbnail,
                        ).image,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover),
              border: Border.all(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(10)),
          child: loaded
              ? const Icon(
                  Icons.error,
                  color: deepBlack,
                  size: 60,
                )
              : null,
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              border: Border.all(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(10)),
        ),
        Positioned(
            //TODO: ensure you change the position here
            bottom: 30,
            left: size.width * 0.2,
            right: size.width * 0.2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: loaded
                  ? null
                  : InkWell(
                      onTap: onTap,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: white400),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.play_arrow_rounded,
                              size: 40,
                              color: white400,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Preview",
                              style: TextStyle(
                                  color: white400,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
            ))
      ],
    );
  }
}
