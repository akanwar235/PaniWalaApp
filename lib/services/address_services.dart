import 'package:dartz/dartz.dart';
import 'package:water_order/dtos/address/address_dto.dart';
import 'package:water_order/dtos/address/update_address_dto.dart';
import 'package:water_order/network/http_client.dart';
import 'package:water_order/services/constants/endpoint_urls.dart';
import 'package:water_order/services/failure.dart';

class AddressService {
  final WAHttpClient client;

  AddressService(this.client);

  Future<Either<Failure, Unit>> addAdddress(AddressDto dto) async {
        try {
      final Map<String, dynamic> data = dto.toJson();

      await client.post(EndPointUrls.addAddress, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

    Future<Either<Failure, Unit>> updateAdddress(UpdateAddressDto dto) async {
        try {
      final Map<String, dynamic> data = dto.toJson();

      await client.post(EndPointUrls.addAddress, data: data);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
