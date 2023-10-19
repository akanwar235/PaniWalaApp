import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:water_order/dtos/create_user_dto.dart';
import 'package:water_order/dtos/get_product_list_dto.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/network/http_client.dart';
import 'package:water_order/services/constants/endpoint_urls.dart';
import 'package:water_order/services/failure.dart';
import 'package:http/http.dart' as http;

class GetProductListService {
  final WAHttpClient client;

  GetProductListService(this.client);

  Future<Either<Failure, List<ProductModel>>> getProductList() async {
    try {
      // TODO: use location selected by user
      GetProductListDto dto =
          const GetProductListDto(lat1: "43.65226", long: "-79.393111");
      final Map<String, dynamic> data = dto.toJson();

      final Response response =
          await client.post(EndPointUrls.getProductList, data: data);
      print(response.data);
      final productList = listProductModelFromJson(response.data);
      return Right(productList);
    } catch (e) {
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  // Stream<Either<Failure, List<ProductModel>>> getProductListStream() async* {
  //   try {
  //     // TODO: use location selected by user
  //     GetProductListDto dto =
  //         const GetProductListDto(lat1: "43.65226", long: "-79.393111");
  //     final Map<String, dynamic> data = dto.toJson();

  //     final Response response =
  //         await client.post(EndPointUrls.getProductList, data: data);
  //     final productList = listProductModelFromJson(response.data);
  //     yield Right(productList);
  //   } catch (e) {
  //     yield Left(Failure(message: e.toString()));
  //   }
  // }
}
