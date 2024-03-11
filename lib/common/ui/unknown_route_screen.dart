import 'package:flutter/material.dart';

import '../../core/l10n/strings.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Text(Strings.unknownRoute.translate(context)),
      ),
    );
  }
}
