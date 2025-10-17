import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;

  const AppCard({super.key, required this.child, this.padding, this.onTap, this.backgroundColor, this.elevation});

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(padding: padding ?? const EdgeInsets.all(AppDimensions.paddingM), child: child);

    if (onTap != null) {
      cardContent = InkWell(onTap: onTap, borderRadius: BorderRadius.circular(AppDimensions.radiusM), child: cardContent);
    }

    return Card(
      elevation: elevation ?? AppDimensions.cardElevation,
      color: backgroundColor ?? AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
      child: cardContent,
    );
  }
}
