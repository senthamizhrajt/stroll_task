import 'package:flutter/material.dart';

import '../../../../common/widgets/asset_icon.dart';
import '../../../../core/theme/app_colors.dart';

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getMenuButton(child: AssetIcon.svg(path: 'assets/icons/poker_cards.svg', height: 24)),
        _getMenuButton(
          child: Stack(
            children: [
              AssetIcon.svg(path: 'assets/icons/fire.svg', height: 24),
              Positioned(
                right: 0,
                top: 0,
                child: Transform.translate(
                  offset: const Offset(12, 0),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).bottomAppBarTheme.color ?? Colors.transparent, width: 2)),
                    child: const Text(
                      '',
                      style: TextStyle(fontSize: 7, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        _getMenuButton(
          child: Stack(
            children: [
              AssetIcon.svg(path: 'assets/icons/chat.svg', height: 24),
              Positioned(
                right: 0,
                top: 0,
                child: Transform.translate(
                  offset: const Offset(8, 0),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).bottomAppBarTheme.color ?? Colors.transparent, width: 2)),
                    child: const Text(
                      '10',
                      style: TextStyle(fontSize: 7, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        _getMenuButton(child: AssetIcon.svg(path: 'assets/icons/user.svg', height: 24)),
      ],
    );
  }

  Widget _getMenuButton({required Widget child}) {
    return MaterialButton(
      onPressed: () {},
      height: double.maxFinite,
      shape: CircleBorder(),
      minWidth: 44,
      child: child,
    );
  }
}
