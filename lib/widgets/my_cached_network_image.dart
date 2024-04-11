// Flutter Packages
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyCachedNetworkImage extends StatelessWidget {
  const MyCachedNetworkImage({
    required this.imageUrl,
    required this.errorWidget,
    required this.imageBuilder,
    this.placeholder,
    this.defaultPlaceholderRadius,
    super.key,
  });

  final String? imageUrl;
  final Widget? placeholder, errorWidget;
  final Widget Function(BuildContext, ImageProvider<Object>) imageBuilder;

  final double? defaultPlaceholderRadius;

  Widget defaultPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        radius: defaultPlaceholderRadius,
        backgroundColor: Colors.black.withOpacity(0.1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageUrl != null && (imageUrl?.isNotEmpty ?? false)
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            placeholder: (context, url) => placeholder ?? defaultPlaceholder(),
            errorWidget: errorWidget != null ? (context, url, error) => errorWidget! : null,
            imageBuilder: imageBuilder,
          )
        : errorWidget ?? Container();
  }
}
