import 'package:birds_learning_network/src/features/modules/courses/view/widgets/resource_row.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:flutter/material.dart';

class ResourcesTabWidget extends StatelessWidget {
  const ResourcesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ResourceRowWidget(
              imageUrl: ImagePath.pdfImage,
              title: "Color Psychology guide.pdf"),
          // SizedBox(height: 10),
          ResourceRowWidget(imageUrl: ImagePath.imageZip, title: "title")
        ],
      ),
    );
  }
}
