// third party
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AsyncImage extends StatelessWidget {
  const AsyncImage(
      this.src, {
        this.placeholder = '',
        this.imageBuilder,
        this.borderRadius = 0,
      });

  final String src;
  final String placeholder;
  final ImageWidgetBuilder imageBuilder;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: src,
      imageBuilder: imageBuilder,
      fit: BoxFit.cover,
      placeholder: (context, url) => imageBuilder != null
          ? imageBuilder(context, AssetImage(placeholder))
          : ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            placeholder,
            fit: BoxFit.cover,
          )
      ),
      errorWidget: (context, url, dynamic _) => imageBuilder != null
          ? imageBuilder(context, AssetImage(placeholder))
          : ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            placeholder,
            fit: BoxFit.cover,
          )
      ),
      fadeInDuration: Duration.zero,
    );
  }
}
