import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkConnection {
  final InternetConnection internetConnectionChecker;
  NetworkConnection({
    required this.internetConnectionChecker,
  });

  Future<bool> get isConnected async {
    return await internetConnectionChecker.hasInternetAccess;
  }
}