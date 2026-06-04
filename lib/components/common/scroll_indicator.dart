import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Container,
        Icon,
        Icons,
        IgnorePointer,
        LinearGradient,
        ScrollController,
        State,
        StatefulWidget,
        Theme,
        Widget;

class ScrollIndicator extends StatefulWidget {
  final double height;
  final double width;
  final ScrollController controller;

  const ScrollIndicator({
    super.key,
    required this.controller,
    this.height = 25,
    this.width = 25,
  });

  @override
  State<ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator> {
  var showScrollIndicator = true;

  @override
  Widget build(BuildContext context) {
    if (!showScrollIndicator) return Container();

    return IgnorePointer(
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: .circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              spreadRadius: 4,
              blurRadius: 10,
              blurStyle: .outer,
            ),
          ],
          gradient: LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface.withValues(alpha: 0),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: const Icon(Icons.arrow_downward, size: 24),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final isAtBottom =
          widget.controller.position.pixels >=
          widget.controller.position.maxScrollExtent - 10;

      if (!showScrollIndicator) return;

      setState(() => showScrollIndicator = !isAtBottom);
    });
  }
}
