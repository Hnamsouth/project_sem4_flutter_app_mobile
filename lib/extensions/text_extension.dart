import 'package:flutter/material.dart';

extension TextExtension on Text {
  ///Apply [TextStyle] to existing textstyle
  Text style({
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    bool? softWrap,
    TextOverflow? overflow,
    TextDirection? textDirection,
    Locale? locale,
    String? semanticsLabel,
    TextScaler? textScaler,
    TextWidthBasis? textWidthBasis,
    int? maxLines,
    TextAlign? textAlign,
  }) =>
      _copyWith(
        key: key,
        style: style,
        strutStyle: strutStyle,
        softWrap: softWrap,
        overflow: overflow,
        textDirection: textDirection,
        locale: locale,
        semanticsLabel: semanticsLabel,
        textScaler: textScaler,
        textWidthBasis: textWidthBasis,
        maxLines: maxLines,
        textAlign: textAlign,
      );

  Text clOnPrimary(BuildContext context) => _copyWith(
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary));

  Text _copyWith(
          {Key? key,
          StrutStyle? strutStyle,
          TextAlign? textAlign,
          TextDirection? textDirection = TextDirection.ltr,
          Locale? locale,
          bool? softWrap,
          TextOverflow? overflow,
          TextScaler? textScaler,
          int? maxLines,
          String? semanticsLabel,
          TextWidthBasis? textWidthBasis,
          TextStyle? style}) =>
      Text(data!,
          key: key ?? this.key,
          strutStyle: strutStyle ?? this.strutStyle,
          textAlign: textAlign ?? this.textAlign,
          textDirection: textDirection ?? this.textDirection,
          locale: locale ?? this.locale,
          softWrap: softWrap ?? this.softWrap,
          overflow: overflow ?? this.overflow,
          textScaler: textScaler ?? this.textScaler,
          maxLines: maxLines ?? this.maxLines,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          textWidthBasis: textWidthBasis ?? this.textWidthBasis,
          style:
              style != null ? this.style?.merge(style) ?? style : this.style);
}
