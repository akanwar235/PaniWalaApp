import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:water_order/dtos/verify_otp_dto.dart';
import 'package:water_order/models/verify_otp_model.dart';
import 'package:water_order/network/http_client.dart';
import 'package:water_order/services/constants/endpoint_urls.dart';
import 'package:water_order/services/failure.dart';

class OtpSerivice {
  final WAHttpClient client;

  OtpSerivice(this.client);

  Future<Either<Failure, Unit>> sendOtp(String phoneNo) async {
    try {
      final Map<String, dynamic> data = {"phone": phoneNo};

      await client.post(EndPointUrls.sendOtp, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, VerifyOtpModel>> verifyOtp(VerifyOtpDto dto) async {
    try {
      final Map<String, dynamic> data = dto.toJson();

      final Response res =
          await client.post(EndPointUrls.verifyOtp, data: data);
      final VerifyOtpModel verifyOtpModel = VerifyOtpModel.fromJson(res.data);
      return Right(verifyOtpModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  // Future<Either<Failure, Unit>> verifyOtpSignUp(VerifyOtpDto dto) async {
  //   try {
  //     final Map<String, dynamic> data = dto.toJson();

  //         await client.post(EndPointUrls.verifyOtp, data: data);
  //     return const Right(unit);
  //   } catch (e) {
  //     return Left(Failure(message: e.toString()));
  //   }
  // }
}
