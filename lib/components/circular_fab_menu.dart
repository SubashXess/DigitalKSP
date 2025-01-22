import 'dart:math';

import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';

const double _buttonSize = 44.0;

class CircularFabMenu extends StatefulWidget {
  const CircularFabMenu({super.key});

  @override
  State<CircularFabMenu> createState() => _CircularFabMenuState();
}

class _CircularFabMenuState extends State<CircularFabMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Durations.medium1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(controller: _controller),
      children: <String>[
        'assets/icons/social-media-facebook.svg',
        'assets/icons/social-media-facebook.svg',
        'assets/icons/social-media-facebook.svg',
        'assets/icons/social-media-facebook.svg',
        'assets/icons/share-outlined.svg',
      ].map<Widget>(_buildFab).toList(),
    );
  }

  Widget _buildFab(String icon) => SizedBox(
        width: _buttonSize,
        height: _buttonSize,
        child: ActionButton(
          icon: icon,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onTap: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
        ),
        // child: FloatingActionButton(
        //   onPressed: () {
        //     if (_controller.status == AnimationStatus.completed) {
        //       _controller.reverse();
        //     } else {
        //       _controller.forward();
        //     }
        //   },
        //   elevation: 0.0,
        //   backgroundColor: Colors.white,
        //   clipBehavior: Clip.none,
        //   child: Icon(icon, size: 24.0, color: Colors.black),
        // ),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  final Animation<double> controller;

  @override
  void paintChildren(FlowPaintingContext context) {
    final int n = context.childCount;

    final size = context.size;
    final xAxis = size.width - _buttonSize;
    final yAxis = size.height - _buttonSize;

    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      setValue(double value) => isLastItem ? 0.0 : value;

      final radius = 120.0 * controller.value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xAxis - setValue(radius * cos(theta));
      final y = yAxis - setValue(radius * sin(theta));

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(_buttonSize / 2.0, _buttonSize / 2.0)
            ..rotateZ(
                isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
            ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
            ..translate(-_buttonSize / 2.0, -_buttonSize / 2.0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
