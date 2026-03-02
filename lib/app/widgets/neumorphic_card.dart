import 'package:flutter/material.dart';
import 'neumorphic_container.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      width: width ?? double.infinity,
      height: height ?? 200,
      padding: padding ?? const EdgeInsets.all(24),
      margin: margin,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      child: child,
    );
  }
}
