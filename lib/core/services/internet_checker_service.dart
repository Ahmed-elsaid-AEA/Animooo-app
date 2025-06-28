import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCheckerService {
  Future<bool> call() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());
    //?mobile data
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
      //?wifi
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return false;
    }
  }
}
