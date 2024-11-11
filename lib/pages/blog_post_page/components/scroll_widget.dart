import 'package:flutter/material.dart';

class ScrollToHideWidget extends StatefulWidget {
  const ScrollToHideWidget({
    super.key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 250),
  });

  final Widget child;
  final ScrollController controller;
  final Duration duration;

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  double lastScrollPosition = 200;
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    _animationController.dispose();
    super.dispose();
  }

  void listen() {
    final currentScrollPosition = widget.controller.position.pixels;

    if (currentScrollPosition > lastScrollPosition && !_isVisible) {
      setState(() => _isVisible = true);
      _animationController.forward();
    } else if (currentScrollPosition <= lastScrollPosition && _isVisible) {
      setState(() => _isVisible = false);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AnimatedSwitcher(
        duration: widget.duration,
        child: _isVisible ? widget.child : const SizedBox.shrink(),
      ),
    );
  }
}
