import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResourceRowWidget extends StatelessWidget {
  const ResourceRowWidget(
      {super.key, required this.imageUrl, required this.title});
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            imageUrl.contains(".com")
                ? Image.network(imageUrl, height: 19, width: 19)
                : SvgPicture.asset(imageUrl, height: 19, width: 19),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: deepBlack,
                    fontFamily: "Inter"),
              ),
            )
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_for_offline_outlined))
      ],
    );
  }
}
