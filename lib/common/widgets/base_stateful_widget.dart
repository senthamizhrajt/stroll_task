import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseWidgetState<T extends BaseStatefulWidget> extends State<T> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive && _appLifecycleState == AppLifecycleState.paused) {
      onRestart();
    } else if (state == AppLifecycleState.paused && _appLifecycleState == AppLifecycleState.inactive) {
      onStop();
    } else if (state == AppLifecycleState.inactive && _appLifecycleState == AppLifecycleState.resumed) {
      onPause();
    } else if (state == AppLifecycleState.resumed && _appLifecycleState == AppLifecycleState.inactive) {
      onResume();
    }
    if (!mounted) return;
    setState(() {
      _appLifecycleState = state;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout());
  }

  void afterFirstLayout() {}

  void onRestart() {}

  void onPause() {}

  void onResume() {}

  void onStop() {}
}
