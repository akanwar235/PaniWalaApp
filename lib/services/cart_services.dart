import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:water_order/dtos/cart/add_item_cart_dto.dart';
import 'package:water_order/dtos/cart/fetch_cart_item_dto.dart';
import 'package:water_order/dtos/cart/remove_item_cart_dto.dart';
import 'package:water_order/dtos/cart/update_item_cart_dto.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/network/http_client.dart';
import 'package:water_order/services/constants/endpoint_urls.dart';
import 'package:water_order/services/failure.dart';

class CartService {
  final WAHttpClient client;

  CartService(this.client);

  Future<Either<Failure, Unit>> addToCart(AddItemCartDto dto) async {
    try {
      final Map<String, dynamic> data = dto.toJson();

      await client.post(EndPointUrls.cart, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> removeFromCart(RemoveItemCartDto dto) async {
    try {
      final Map<String, dynamic> data = dto.toJson();

      await client.post(EndPointUrls.cart, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> updateItemCount(UpdateItemCartDto dto) async {
    try {
      final Map<String, dynamic> data = dto.toJson();

      await client.post(EndPointUrls.cart, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> fetchCartItem(
      FetchCardItemDto dto) async {
    try {
      final Map<String, dynamic> data = dto.toJson();

      final Response res = await client.post(EndPointUrls.cart, data: data);

      return Right(listProductModelFromJson(res.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
