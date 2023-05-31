import 'package:flutter/material.dart';

/// A simple & lightweight widget to display a animated skeleton effect.
///
/// Making a skeleton of a widget with skeleton effect while loading data from server or any other source is a common task that can be easily done with [XSkeleton] widget.
/// [XSkeleton] is a simple yet very useful [Widget] that developers can use it to create an awesome animated skeleton effect for any widget skeleton loading.
///
/// It's easy, just give the widget height and width and it will create a skeleton effect for you,
/// further you can customize the skeleton effect by giving [startColor], [endColor], [borderRadius] and [delayInMilliSeconds] properties.
///
/// - @required [height] : accepts a [double] to set height of the skeleton effect
/// - @required [width] : accepts a [double] to set width of the skeleton effect
/// - [startColor] : accepts a [Color] and sets the start color of the skeleton effect from which animation will start
/// - [endColor] : accepts a [Color] and sets the end color of the skeleton effect to which animation will end
/// - [borderRadius] : accepts a [BorderRadius] and sets the border radius of the animated skeleton widget
/// - [delayInMilliSeconds] : accepts a [Duration] that would be the delay in starting the animation. Default value is [Duration.zero]
class XSkeleton extends StatefulWidget {
  XSkeleton({
    required this.height,
    required this.width,
    super.key,
    this.borderRadius = 0,
    this.startColor = const Color(0xffE6E8EB),
    this.endColor = const Color(0x77E6E8EB),
    this.delayInMilliSeconds = Duration.zero,
    this.aspectRatio,
    this.boxDecoration,
    this.shape,
  });

  /// Use this to create a round loading widget
  factory XSkeleton.round({
    required double? size,
    Color? startColor = const Color(0xffE6E8EB),
    Color? endColor = const Color(0x77E6E8EB),
    Duration delayInMilliSeconds = Duration.zero,
  }) =>
      XSkeleton(
        height: size,
        width: size,
        startColor: startColor,
        endColor: endColor,
        shape: BoxShape.circle,
      );

  /// Use this to create a square loading widget
  factory XSkeleton.square({
    required double? size,
    Color? startColor = const Color(0xffE6E8EB),
    Color? endColor = const Color(0x77E6E8EB),
    Duration delayInMilliSeconds = Duration.zero,
  }) =>
      XSkeleton(
        height: size,
        width: size,
        startColor: startColor,
        endColor: endColor,
      );

  /// Use this to create a ratio loading widget
  factory XSkeleton.ratio({
    required double? aspectRatio,
    double? height,
    double? width,
    Color? startColor = const Color(0xffE6E8EB),
    Color? endColor = const Color(0x77E6E8EB),
    Duration delayInMilliSeconds = Duration.zero,
  }) {
    if (aspectRatio != null) {
      assert(
          height == null || width == null, 'Either height or width only if Aspect Ratio available');
    }
    return XSkeleton(
      height: height,
      width: width,
      aspectRatio: aspectRatio,
      startColor: startColor,
      endColor: endColor,
    );
  }

  /// Accepts a [double], set width of the skeleton effect
  final double? width;

  /// Accepts a [double], set height of the skeleton effect
  final double? height;

  /// Accepts a [Color], set start color of the skeleton effect from which animation will start
  final Color? startColor;

  /// Accepts a [Color], set end color of skeleton effect to which animation will end
  final Color? endColor;

  /// Accepts a [BorderRadius], set border radius of the widget
  /// Default value is [0]
  final double borderRadius;

  /// Accepts a [Duration] that would be the delay in starting the animation.
  /// Default value is [Duration.zero]
  final Duration delayInMilliSeconds;

  /// Accepts a [aspectRatio] that would show with aspect ratio size.
  final double? aspectRatio;

  /// Accepts a [BoxDecoration] that would customize container which wrapped the skeleton.
  final BoxDecoration? boxDecoration;

  /// Accepts a [BoxShape], set shape of the widget.
  final BoxShape? shape;

  @override
  State<StatefulWidget> createState() => SkeletonState();
}

class SkeletonState extends State<XSkeleton> with SingleTickerProviderStateMixin {
  // AnimationController for starting and driving the animation
  late AnimationController _animationController;
  // Animation which will hold the ColorTween values
  late Animation _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Initializing AnimationController
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    // ColorTween Animation
    _colorAnimation =
        ColorTween(begin: widget.startColor, end: widget.endColor).animate(_animationController);

    // Trigger the animation only after build is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if any delay is requested
      if (widget.delayInMilliSeconds.inMilliseconds == 0) {
        _animationController.forward();
      } else {
        Future.delayed(widget.delayInMilliSeconds, () {
          // start the animation
          _animationController.forward();
        });
      }
    });

    // Adding listener to the AnimationController so that
    // we can put it in a loop based on it's status
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reverse the animation if it's completed
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Restart the animation if it's dismissed
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.shape == BoxShape.circle
        ? ClipOval(child: _content())
        // LayoutBuilder(
        //     builder: (_, constraints) {
        //       return ClipOval(child: _content(boxConstraints: constraints));
        //     },
        //   )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: _content(),
          );
  }

  Widget _content({BoxConstraints? boxConstraints}) {
    double? height;
    double? width;
    height = widget.height;
    width = widget.width;

    // if (widget.shape == BoxShape.circle) {
    //   if (widget.height != null) {
    //     height = widget.height;
    //     width = widget.height;
    //   } else {
    //     height = boxConstraints!.maxWidth;
    //     width = boxConstraints.maxWidth;
    //   }
    // } else {
    //   height = widget.height;
    //   width = widget.width;
    // }
    return Container(
      decoration: widget.boxDecoration,
      height: height,
      width: width,
      child: widget.aspectRatio == null
          ? _animatedBody()
          : AspectRatio(
              aspectRatio: widget.aspectRatio ?? 1,
              child: _animatedBody(),
            ),
    );
  }

  Widget _animatedBody() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose the AnimationController when the widget is disposed
    _animationController.dispose();
    super.dispose();
  }
}
