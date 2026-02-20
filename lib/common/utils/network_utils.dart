import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> hasInternetConnection() async {
    final List<ConnectivityResult> connectivityResults =
        await (Connectivity().checkConnectivity());

    return connectivityResults.any(
      (result) => result != ConnectivityResult.none,
    );
  }
}
