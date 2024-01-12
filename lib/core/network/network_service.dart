import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityService {
  final BehaviorSubject<ConnectivityResult> _connectionStatusController =
      BehaviorSubject<ConnectivityResult>();
  ConnectivityResult? get currentConnectionStatus =>
      _connectionStatusController.valueOrNull;
  Stream<ConnectivityResult> get connectionStatusStream =>
      _connectionStatusController.stream;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (_connectionStatusController.valueOrNull != result)
        _connectionStatusController.add(result);
    });
  }

  bool get isMobileConnection =>
      currentConnectionStatus == ConnectivityResult.mobile;

  bool get isWifiConnection =>
      currentConnectionStatus == ConnectivityResult.wifi;

  bool get hasInternetConnection => isMobileConnection || isWifiConnection;
}
