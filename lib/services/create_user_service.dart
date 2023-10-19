import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:water_order/dtos/create_user_dto.dart';
import 'package:water_order/models/verify_otp_model.dart';
import 'package:water_order/network/http_client.dart';
import 'package:water_order/services/constants/endpoint_urls.dart';
import 'package:water_order/services/failure.dart';
import 'package:http/http.dart' as http;

class CreateAccountService {
  final WAHttpClient client;

  CreateAccountService(this.client);

  Future<Either<Failure, VerifyOtpModel>> createUser(
      CreateUserDto dto) async {
    try {
      final Map<String, dynamic> data = dto.toJson();
      final Response response =
          await client.post(EndPointUrls.createAccount, data: data);
      return Right(VerifyOtpModel.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
