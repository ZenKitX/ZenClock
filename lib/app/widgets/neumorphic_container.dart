import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isPressed;
  final BorderRadius? borderRadius;

  const NeumorphicContainer({
    super.key,
    this.child,
    this.width = 100,
    this.height = 100,
    this.padding,
    this.margin,
    this.isPressed = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final radius = borderRadius ?? BorderRadius.circular(16);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius,
        boxShadow: isPressed
            ? _getPressedShadows(isDark)
            : _getNormalShadows(isDark),
      ),
      child: padding != null
          ? Padding(padding: padding!, child: child)
          : child,
    );
  }

  List<BoxShadow> _getNormalShadows(bool isDark) {
    if (isDark) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.05),
          offset: const Offset(-4, -4),
          blurRadius: 8,
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-4, -4),
          blurRadius: 8,
        ),
      ];
    }
  }

  List<BoxShadow> _getPressedShadows(bool isDark) {
    if (isDark) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          offset: const Offset(-2, -2),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.05),
          offset: const Offset(2, 2),
          blurRadius: 4,
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(-2, -2),
          blurRadius: 4,
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(2, 2),
          blurRadius: 4,
        ),
      ];
    }
  }
}
