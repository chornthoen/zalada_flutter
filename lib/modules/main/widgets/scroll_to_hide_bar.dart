import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  const ScrollToHideWidget({
    super.key,
    required this.child,
    required this.controller,
    required this.duration,
  });

  final Widget child;
  final ScrollController controller;
  final Duration duration;

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    widget.controller.addListener(listen);
    super.initState();
  }

  void listen() {
    if (widget.controller.position.userScrollDirection ==
        ScrollDirection.reverse) {
      hide();
    } else if (widget.controller.position.userScrollDirection ==
        ScrollDirection.forward) {
      show();
    }
  }

  void hide() {
    setState(() {
      isVisible = false;
    });
  }

  void show() {
    setState(() {
      isVisible = true;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? 100.0 : 0.0,
      child: Wrap(
        children: [
          widget.child,
        ],
      ),
    );
  }
}
