import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> hasInternetConnection() async {
    List<ConnectivityResult> connectivityResults =
        await (Connectivity().checkConnectivity());
    final bool hasNetworkConnection =
        connectivityResults.contains(ConnectivityResult.mobile) ||
            connectivityResults.contains(ConnectivityResult.wifi);
    return hasNetworkConnection;
  }
}
