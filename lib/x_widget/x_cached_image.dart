import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:baseX/base_x.dart';
import 'package:cached_network_image/cached_network_image.dart';

class XCachedImage extends StatefulWidget {
  XCachedImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    super.key,
    this.borderRadius = 0,
    this.fit,
    this.loaderColor = CupertinoColors.activeBlue,
    this.errorWidget,
    this.placeholder,
    this.httpHeaders,
    this.errorIcon = const Icon(
      Icons.image_not_supported,
      size: 35,
      color: Colors.red,
    ),
    this.defaultBackground = const Color(0xFFE4E5E8),
  });

  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit? fit;
  final Color loaderColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Map<String, String>? httpHeaders;
  final Icon errorIcon;
  final Color defaultBackground;

  @override
  State<StatefulWidget> createState() => XCachedImageState();
}

class XCachedImageState extends State<XCachedImage> {
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    width = widget.width;
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        width: width,
        height: height,
        fit: widget.fit,
        httpHeaders: widget.httpHeaders ?? {},
        errorWidget: (_, url, error) {
          XLogger.error('$url on $error.');

          return SizedBox(
            width: width,
            height: height,
            child: widget.errorWidget ??
                ColoredBox(
                  color: widget.defaultBackground,
                  child: widget.errorIcon,
                ),
          );
        },
        placeholder: (_, url) {
          XLogger.success('$url loaded.');

          return SizedBox(
            width: width,
            height: height,
            child: widget.placeholder ??
                ColoredBox(
                  color: widget.defaultBackground,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: widget.loaderColor,
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
