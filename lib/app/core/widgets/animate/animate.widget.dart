import 'dart:async';

import 'package:flutter/material.dart';

class AnimateWidget extends StatefulWidget {
  final Widget child;
  final int? delay;
  final Curve? curve;

  const AnimateWidget({super.key, required this.child, this.delay, this.curve});

  @override
  _AnimateWidgetState createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    final curve = CurvedAnimation(
        curve: widget.curve ?? Curves.linear, parent: _controller);
    _animOffset = Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero)
        .animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay ?? 0), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
