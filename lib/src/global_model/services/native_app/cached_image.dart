import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key,
    this.imageBuilder,
    this.errorWidget,
    this.placeholder,
    this.height,
    this.width,
    required this.imageUrl
  });

  final String imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget? errorWidget;
  final Widget? placeholder;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      placeholder:(context, url) => placeholder ?? const Center(
          child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => Center(
        child: SizedBox(
          height: height,
          width: width,
          child: errorWidget ?? const Icon(Icons.error, size: 30)
        )
      ),
      imageBuilder: imageBuilder
    );
  }
}
