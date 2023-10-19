import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_network_info.dart';

///networkInfoProvider
final networkInfoProvider = Provider((ref) {
  final connection = InternetConnectionChecker();
  return NetworkInfoImpl(connection);
});

class NetworkInfoImpl implements INetworkInfo {
  final InternetConnectionChecker connection;

  NetworkInfoImpl(this.connection);

  @override
  Future<bool> get isConnected => connection.hasConnection;
}
