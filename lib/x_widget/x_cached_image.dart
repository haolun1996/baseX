import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:baseX/base_x.dart';
import 'package:cached_network_image/cached_network_image.dart';

class XCachedImage extends StatefulWidget {
  XCachedImage({
    // Plugin properties
    required this.imageUrl,
    super.key,
    this.httpHeaders,
    // Placeholder and Loading properties
    this.placeholder,
    // Loader Color
    this.loaderColor = CupertinoColors.activeBlue,
    // Widget properties
    this.borderRadius = 0,
    this.defaultBackground = const Color(0xFFE4E5E8),
    this.aspectRatio,
    // Error properties
    this.errorWidget,
    this.errorIcon = const Icon(
      Icons.image_not_supported,
      size: 35,
      color: CupertinoColors.systemGrey2,
    ),
    // Container properties
    this.width,
    this.height,
    this.boxDecoration,
    // Image properties
    this.fit = BoxFit.cover,
    this.alignment,
    this.colorBlendMode,
    this.opacity,
    this.color,
    this.filterQuality = FilterQuality.low,
    // Circle
    this.shape,
    // Placeholder properties
    this.hasSkeleton = false,
  });

  /// Use this to create a round widget
  factory XCachedImage.round({
    // Plugin properties
    required String imageUrl,
    Map<String, String>? httpHeaders,
    // Placeholder and Loading properties
    Widget? placeholder,
    // Loader Color
    Color loaderColor = CupertinoColors.activeBlue,
    // Widget properties
    Color defaultBackground = const Color(0xFFE4E5E8),
    // Error properties
    Widget? errorWidget,
    Icon errorIcon = const Icon(
      Icons.image_not_supported,
      size: 35,
      color: CupertinoColors.systemGrey2,
    ),
    // Container properties
    double? size,
    BoxDecoration? boxDecoration,
    // Image properties
    BoxFit fit = BoxFit.cover,
    Alignment? alignment,
    BlendMode? colorBlendMode,
    Animation<double>? opacity,
    Color? color,
    FilterQuality filterQuality = FilterQuality.low,
    // Placeholder properties
    bool hasSkeleton = false,
  }) =>
      XCachedImage(
        // Plugin properties
        imageUrl: imageUrl,
        httpHeaders: httpHeaders,
        // Placeholder and Loading properties
        placeholder: placeholder,
        // Loader Color
        loaderColor: loaderColor,
        // Widget properties
        defaultBackground: defaultBackground,
        // Error properties
        errorWidget: errorWidget,
        errorIcon: errorIcon,
        // Container properties
        height: size,
        boxDecoration: boxDecoration,
        fit: fit,
        alignment: alignment,
        opacity: opacity,
        color: color,
        filterQuality: filterQuality,
        shape: BoxShape.circle,
        // Placeholder properties
        hasSkeleton: hasSkeleton,
      );

  // Plugin properties
  final String imageUrl;
  final Map<String, String>? httpHeaders;
  // Placeholder and Loading properties
  final Widget? placeholder;
  // Loader Color
  final Color loaderColor;
  // Widget properties
  final double borderRadius;
  final Color defaultBackground;
  final double? aspectRatio;
  // Error properties
  final Widget? errorWidget;
  final Icon errorIcon;
  // Container properties
  final double? width;
  final double? height;
  final BoxDecoration? boxDecoration;
  // Image properties
  final BoxFit fit;
  final Alignment? alignment;
  final BlendMode? colorBlendMode;
  final Animation<double>? opacity;
  final Color? color;
  final FilterQuality filterQuality;
  final BoxShape? shape;
  // Placeholder properties
  final bool hasSkeleton;

  @override
  State<StatefulWidget> createState() => XCachedImageState();
}

class XCachedImageState extends State<XCachedImage> {
  double? height;
  double? width;

  @override
  void initState() {
    super.initState();

    if (widget.shape == BoxShape.circle && widget.height == null) {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.aspectRatio != null) {
      assert(widget.height == null || widget.width == null,
          'Either height or width only if Aspect Ratio available');
    }

    // if (widget.shape == BoxShape.circle) {
    //   assert(widget.height != null, 'Circle image need height');
    // }

    return widget.shape == BoxShape.circle
        ? LayoutBuilder(
            builder: (_, constraints) {
              return ClipOval(child: _image(boxConstraints: constraints));
            },
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: _image(),
          );
  }

  Widget _image({BoxConstraints? boxConstraints}) {
    if (widget.shape == BoxShape.circle) {
      if (widget.height != null) {
        height = widget.height;
        width = widget.height;
      } else {
        height = boxConstraints!.maxWidth;
        width = boxConstraints.maxWidth;
      }
    } else {
      height = widget.height;
      width = widget.width;
    }
    return Container(
      decoration: widget.boxDecoration,
      height: height,
      width: width,
      child: widget.aspectRatio == null
          ? _cachedImage()
          : AspectRatio(
              aspectRatio: widget.aspectRatio ?? 1,
              child: _cachedImage(),
            ),
    );
  }

  Widget _cachedImage() {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      httpHeaders: widget.httpHeaders,
      imageBuilder: (_, imageProvider) {
        XLogger.success(className: 'XCachedImage', 'loaded from cache.');

        return Image(
          image: imageProvider,
          fit: widget.fit,
          alignment: widget.alignment ?? Alignment.center,
          colorBlendMode: widget.colorBlendMode,
          opacity: widget.opacity,
          color: widget.color,
          filterQuality: widget.filterQuality,
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        if (progress.progress == 1.0) {
          XLogger.success(className: 'XCachedImage', '$url loaded from url.');
        }

        if (widget.hasSkeleton) {
          return widget.aspectRatio == null
              ? XSkeleton(height: height, width: width)
              : XSkeleton.ratio(
                  aspectRatio: widget.aspectRatio,
                  height: widget.height != null ? height : null,
                  width: widget.width != null ? width : null,
                );
        } else {
          return SizedBox.expand(
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
        }
      },
      errorWidget: (_, url, error) {
        XLogger.error(className: 'XCachedImage', '$url on $error.');

        return widget.errorWidget ??
            ColoredBox(
              color: widget.defaultBackground,
              child: widget.errorIcon,
            );
      },
    );
  }
}
