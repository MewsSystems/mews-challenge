import 'package:flutter/widgets.dart';

class MewsCard extends StatelessWidget {
  const MewsCard({
    Key key,
    this.child,
    this.padding,
    this.margin,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
