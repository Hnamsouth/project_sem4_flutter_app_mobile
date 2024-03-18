import 'package:flutter/material.dart';

class CircleAvatarWithBorderWidget extends StatelessWidget {
  CircleAvatarWithBorderWidget(
      {super.key,
      required this.width,
      required this.height,
      this.image,
      this.icon,
      this.backgroundColor,
      this.borderColor});
  final double width;
  final double height;
  final String? image;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 1.5,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 1.5,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
          );
  }
}
