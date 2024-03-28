import 'package:flutter/material.dart';

@immutable
class VeryBigText extends Text {
  const VeryBigText(
    super.data, {
    super.key,
    required this.context,
    this.textStyle,
    this.maxLine,
  });

  VeryBigText copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    bool isLineThrough = false,
  }) {
    return VeryBigText(
      data,
      context: context,
      textStyle: TextStyle(
        decoration:
            isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize:
            fontSize ?? Theme.of(context).primaryTextTheme.titleLarge!.fontSize,
        fontWeight: fontWeight ??
            Theme.of(context).primaryTextTheme.titleLarge!.fontWeight,
        color: color ?? Theme.of(context).primaryTextTheme.titleLarge!.color,
        fontStyle: fontStyle ??
            Theme.of(context).primaryTextTheme.titleLarge!.fontStyle,
      ),
    );
  }

  final TextStyle? textStyle;
  final int? maxLine;
  final BuildContext context;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style =>
      textStyle ?? Theme.of(context).primaryTextTheme.titleLarge!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int? get maxLines => maxLine;
}

@immutable
class BigText extends Text {
  const BigText(super.data,
      {super.key, required this.context, this.textStyle, this.maxLine});

  BigText copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    bool isLineThrough = false,
  }) {
    return BigText(
      data,
      context: context,
      textStyle: TextStyle(
        decoration:
            isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize: fontSize ??
            Theme.of(context).primaryTextTheme.titleMedium!.fontSize,
        fontWeight: fontWeight ??
            Theme.of(context).primaryTextTheme.titleMedium!.fontWeight,
        color: color ?? Theme.of(context).primaryTextTheme.titleMedium!.color,
        fontStyle: fontStyle ??
            Theme.of(context).primaryTextTheme.titleMedium!.fontStyle,
      ),
    );
  }

  final TextStyle? textStyle;
  final int? maxLine;
  final BuildContext context;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style =>
      textStyle ?? Theme.of(context).primaryTextTheme.titleMedium!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int? get maxLines => maxLine;
}

@immutable
class MediumText extends Text {
  const MediumText(
    super.data, {
    super.key,
    required this.context,
    this.textStyle,
    this.maxLine,
  });

  MediumText copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    bool isLineThrough = false,
  }) {
    return MediumText(
      data,
      context: context,
      textStyle: TextStyle(

        decoration:
            isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize:
            fontSize ?? Theme.of(context).primaryTextTheme.bodyLarge!.fontSize,
        fontWeight: fontWeight ??
            Theme.of(context).primaryTextTheme.bodyLarge!.fontWeight,
        color: color ?? Theme.of(context).primaryTextTheme.bodyLarge!.color,
        fontStyle: fontStyle ??
            Theme.of(context).primaryTextTheme.bodyLarge!.fontStyle,
      ),
    );
  }

  final TextStyle? textStyle;
  final int? maxLine;
  final BuildContext context;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style =>
      textStyle ?? Theme.of(context).primaryTextTheme.bodyLarge!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int? get maxLines => maxLine;
}

@immutable
class SmallText extends Text {
  const SmallText(
    super.data, {
    super.key,
    required this.context,
    this.textStyle,
    this.maxLine,
  });

  SmallText copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    bool isLineThrough = false,
  }) {
    return SmallText(
      data,
      context: context,
      textStyle: TextStyle(
        decoration:
            isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize:
            fontSize ?? Theme.of(context).primaryTextTheme.bodyMedium!.fontSize,
        fontWeight: fontWeight ??
            Theme.of(context).primaryTextTheme.bodyMedium!.fontWeight,
        color: color ?? Theme.of(context).primaryTextTheme.bodyMedium!.color,
        fontStyle: fontStyle ??
            Theme.of(context).primaryTextTheme.bodyMedium!.fontStyle,
      ),
    );
  }

  final TextStyle? textStyle;
  final int? maxLine;
  final BuildContext context;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style =>
      textStyle ?? Theme.of(context).primaryTextTheme.bodyMedium!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int? get maxLines => maxLine;
}

@immutable
class VerySmallText extends Text {
  const VerySmallText(
    super.data, {
    super.key,
    required this.context,
    this.textStyle,
    this.maxLine,
  });

  VerySmallText copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    bool isLineThrough = false,
  }) {
    return VerySmallText(
      data,
      context: context,
      textStyle: TextStyle(
        decoration:
            isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize:
            fontSize ?? Theme.of(context).primaryTextTheme.bodySmall!.fontSize,
        fontWeight: fontWeight ??
            Theme.of(context).primaryTextTheme.bodySmall!.fontWeight,
        color: color ?? Theme.of(context).primaryTextTheme.bodySmall!.color,
        fontStyle: fontStyle ??
            Theme.of(context).primaryTextTheme.bodySmall!.fontStyle,
      ),
    );
  }

  final TextStyle? textStyle;
  final int? maxLine;
  final BuildContext context;

  @override
  String get data => "${super.data}";

  @override
  TextStyle get style =>
      textStyle ?? Theme.of(context).primaryTextTheme.bodySmall!;

  @override
  TextOverflow get overflow => TextOverflow.fade;

  @override
  int? get maxLines => maxLine;
}
