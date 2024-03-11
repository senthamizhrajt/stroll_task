import 'package:flutter/material.dart';

class AnswerToggleButtons extends StatefulWidget {
  final Function(int value)? onToggle;
  final Color? selectedColor;
  final EdgeInsets padding;

  final List<String> optionsList;

  const AnswerToggleButtons({
    super.key,
    this.onToggle,
    this.selectedColor,
    this.padding = const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
    required this.optionsList,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnswerToggleButtonsState();
  }
}

class _AnswerToggleButtonsState extends State<AnswerToggleButtons> {
  int selectedIndex = -1;
  final optionIndexText = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _getRadioButton(widget.optionsList[0], 0),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _getRadioButton(widget.optionsList[1], 1),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _getRadioButton(widget.optionsList[2], 2),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _getRadioButton(widget.optionsList[3], 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getRadioButton(String text, int value) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      color: selectedIndex == value ? widget.selectedColor : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //style: TextButton.styleFrom(alignment: Alignment.centerLeft, padding: EdgeInsets.all(0)),
      onPressed: () {
        if (widget.onToggle != null) {
          widget.onToggle!(value);
        }
        setState(() {
          selectedIndex = value;
        });
      },
      child: Container(
          padding: widget.padding,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selectedIndex == value ? widget.selectedColor ?? Colors.transparent : Colors.transparent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              BoxShadow(
                color: Theme.of(context).cardColor,
                spreadRadius: -1.0,
                blurRadius: 0.1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: selectedIndex == value ? widget.selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: selectedIndex == value ? 0 : 1),
                ),
                child: Text(
                  optionIndexText[value],
                  style: TextStyle(
                    color: selectedIndex == value ? Theme.of(context).secondaryHeaderColor : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
