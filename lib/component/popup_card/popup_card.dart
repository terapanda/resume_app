// NOTE: Most of the credit for this code goes to 'funwithflutter' on GitHub
library popup_card;

import 'package:flutter/material.dart';
import 'package:resume_app/component/popup_card/hero_route.dart';

// [PopupItemLauncher], when wrapped around a widget like an [Icon], launches the [PopUpItem] widget.
class PopupItemLauncher extends StatelessWidget {
  final Object? tag;
  final Widget? card;
  final Widget? popUp;
  final EdgeInsetsGeometry padding;
  const PopupItemLauncher(
      {Key? key,
      this.tag,
      this.card,
      this.popUp,
      this.padding = const EdgeInsets.all(32.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return popUp!;
          }));
        },
        child: Hero(
          tag: tag!,
          child: card!,
        ),
      ),
    );
  }
}

// This is the actual pop up card. You provide this to [PopUpItemLauncher].
class PopUpItem extends StatelessWidget {
  final Object tag;
  final Widget child;
  final Color color;
  final double elevation;
  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry innerPadding;
  final ShapeBorder shape;
  final double height;
  PopUpItem({
    Key? key,
    required this.tag,
    required this.child,
    required this.color,
    required this.outerPadding,
    required this.innerPadding,
    required this.shape,
    this.height = 200,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: outerPadding,
        child: Hero(
          tag: tag,
          child: SizedBox(
            height: height,
            child: Material(
              color: color,
              elevation: elevation,
              shape: shape,
              child: SingleChildScrollView(
                child: Padding(
                  padding: innerPadding,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
