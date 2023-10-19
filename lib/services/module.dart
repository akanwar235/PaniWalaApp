import 'package:water_order/network/http_client.dart';
import 'package:water_order/services/cart_services.dart';
import 'package:water_order/services/create_user_service.dart';
import 'package:water_order/services/local_database.dart';
import 'package:water_order/services/otp_service.dart';
import 'package:water_order/services/get_product_list_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///GetProductListService
final productListServiceProvider = Provider((ref) {
  final client = ref.read(httpClientProvider);
  return GetProductListService(client);
});

final prodductListFutureProvider = FutureProvider((ref) async {
  return ref.read(productListServiceProvider).getProductList();
});

///OtpSerivice
final otpServiceProvider = Provider((ref) {
  final client = ref.read(httpClientProvider);
  return OtpSerivice(client);
});

///CartService
final cartServiceProvider = Provider((ref) {
  final wAHttpClient = ref.read(httpClientProvider);
  return CartService(wAHttpClient);
});

///CreateAccountService
final createAccountProvider = Provider((ref) {
  final client = ref.read(httpClientProvider);
  return CreateAccountService(client);
});

///Local Database
final localDbProvider = Provider((ref) {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  return LocalDataBase(storage: storage);
});
