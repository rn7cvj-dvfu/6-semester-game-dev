import 'package:flutter/widgets.dart';
import 'statistics_service.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const AppLifecycleObserver({super.key, required this.child});

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  late final StatisticsService _statisticsService;

  @override
  void initState() {
    super.initState();
    _statisticsService = StatisticsService.instance;
    WidgetsBinding.instance.addObserver(this);
    _statisticsService.startPlayTimeTracking();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _statisticsService.startPlayTimeTracking();
      case AppLifecycleState.inactive:
        _statisticsService.stopPlayTimeTracking();
      case AppLifecycleState.paused:
        _statisticsService.stopPlayTimeTracking();
      case AppLifecycleState.detached:
        _statisticsService.onAppDispose();
      case AppLifecycleState.hidden:
        _statisticsService.stopPlayTimeTracking();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _statisticsService.onAppDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
