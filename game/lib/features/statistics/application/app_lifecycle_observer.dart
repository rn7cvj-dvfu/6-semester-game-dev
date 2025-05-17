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
    // Initial start for play time, in case 'resumed' is not immediately called
    // or if the app starts directly in foreground.
    _statisticsService.startPlayTimeTracking();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _statisticsService.startPlayTimeTracking();
        break;
      case AppLifecycleState.inactive:
        // inactive could be a precursor to paused, we typically handle saving in paused or detached.
        // If on iOS, inactive means app is not responding to user events but still running.
        // Might stop timer here if strictness about "active play time" is needed.
        _statisticsService
            .stopPlayTimeTracking(); // Stop and save current session
        break;
      case AppLifecycleState.paused:
        // App is not visible. Good time to save state.
        _statisticsService.stopPlayTimeTracking();
        break;
      case AppLifecycleState.detached:
        // App is about to be destroyed. Last chance to save.
        _statisticsService.onAppDispose(); // Final save and cleanup
        break;
      case AppLifecycleState
          .hidden: // New state in Flutter 3.13 for desktop/web when window is hidden
        _statisticsService.stopPlayTimeTracking();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Ensure final play time is recorded and resources cleaned up
    // This might be redundant if 'detached' was already called, but good for safety.
    _statisticsService.onAppDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
