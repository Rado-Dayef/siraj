import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:siraj/core/services/image_cash_manager.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final BoxFit fit;
  final String imageUrl;
  final double? height, width;
  final double size, errorLoadingSize;

  const CachedNetworkImageWidget(this.imageUrl, {this.height, this.width, this.fit = BoxFit.cover, this.size = 24, this.errorLoadingSize = 18, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl,
      width: width ?? size,
      height: height ?? size,
      cacheManager: ImageCacheManager.instance,
      placeholder: (context, url) {
        return SizedBox(
          width: errorLoadingSize,
          height: errorLoadingSize,
          child: SizedBox(width: size, height: size, child: 24.darkLoading),
        );
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error_outline_rounded, color: AppColors.whiteColor, size: errorLoadingSize);
      },
    );
  }
}
