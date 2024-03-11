import 'package:flutter/material.dart';

import 'app_button.dart';

class DialogUtils {
  Future<T?> showAlertDialog<T>(
    BuildContext context,
    String? title,
    String message,
    List? actionButtons, {
    String positiveButtonText = 'Close',
    bool isBackButtonDismissible = false,
    bool isPopScreen = false,
    Axis orientation = Axis.horizontal,
    EdgeInsets insetsPadding = const EdgeInsets.all(24),
    VoidCallback? onPositiveButtonClicked,
  }) async {
    Widget okButton = AppButton.accent(
      text: positiveButtonText,
      shrink: true,
      onPressed: () {
        if (onPositiveButtonClicked != null) onPositiveButtonClicked();
        Navigator.of(context).pop();
        if (isPopScreen) {
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsPadding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: insetsPadding,
      title: title == null || title.isEmpty ? null : Text(title),
      content: SingleChildScrollView(child: Text(message)),
      actions: actionButtons != null
          ? [
              if (orientation == Axis.horizontal)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (actionButtons.isEmpty) okButton,
                    if (actionButtons.isNotEmpty) actionButtons[0],
                    if (actionButtons.length > 1) const SizedBox(width: 8),
                    if (actionButtons.length > 1) actionButtons[1],
                    if (actionButtons.length > 2) const SizedBox(width: 8),
                    if (actionButtons.length > 2) actionButtons[2],
                  ],
                ),
              if (orientation == Axis.vertical)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (actionButtons.isEmpty) okButton,
                    if (actionButtons.isNotEmpty) actionButtons[0],
                    if (actionButtons.length > 1) const SizedBox(height: 8),
                    if (actionButtons.length > 1) actionButtons[1],
                    if (actionButtons.length > 2) const SizedBox(height: 8),
                    if (actionButtons.length > 2) actionButtons[2],
                  ],
                )
            ]
          : null,
    );

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(canPop: false, child: alert);
      },
    );
  }
}
