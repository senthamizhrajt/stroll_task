import 'package:flutter/material.dart';

class BidirectionalScrollView extends StatefulWidget {
  final Widget child;

  const BidirectionalScrollView({Key? key, required this.child})
      : super(key: key);

  @override
  _BidirectionalScrollViewState createState() =>
      _BidirectionalScrollViewState();
}

class _BidirectionalScrollViewState extends State<BidirectionalScrollView> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  bool _syncInProgress = false;

  @override
  void initState() {
    super.initState();
    _horizontalController.addListener(_syncScroll);
    _verticalController.addListener(_syncScroll);
  }

  @override
  void dispose() {
    _horizontalController.removeListener(_syncScroll);
    _verticalController.removeListener(_syncScroll);
    super.dispose();
  }

  void _syncScroll() {
    if (!_syncInProgress) {
      _syncInProgress = true;
      _horizontalController.jumpTo(_horizontalController.offset);
      _verticalController.jumpTo(_verticalController.offset);
      _syncInProgress = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification ||
            notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          _horizontalController.jumpTo(_horizontalController.offset);
          _verticalController.jumpTo(_verticalController.offset);
        }
        return true;
      },
      child: SingleChildScrollView(
        controller: _verticalController,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          child: widget.child,
        ),
      ),
    );
  }
}