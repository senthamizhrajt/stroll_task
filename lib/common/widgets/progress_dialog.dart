import 'package:flutter/material.dart';

class ProgressDialog {
  static bool _isShowing = false;

  static show(BuildContext context, {Widget? child, bool isTransparent = false}) {
    if (_isShowing) {
      return;
    }

    _isShowing = true;
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetAnimationDuration: const Duration(milliseconds: 100),
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                    width: 72,
                    height: 72,
                  child: CircularProgressIndicator()
                ),*/
                if (child != null) child
              ],
            ),
          ),
        );
      },
    );
  }

  static dismiss(BuildContext context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context).pop(true);
    }
  }
}
