// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_dto.freezed.dart';
part 'address_dto.g.dart';

@freezed
class AddressDto with _$AddressDto {
  factory AddressDto({
    @JsonKey(name: 'customerId') required String customerId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'latitude') required String latitude,
    @JsonKey(name: 'longitude') required String longitude,
    @JsonKey(name: 'houseNumber') required String houseNumber,
    @JsonKey(name: 'street') required String street,
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'state') required String state,
    @JsonKey(name: 'pin') required String pin,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'landmark') required String landmark,
    @JsonKey(name: 'isDefault') required String isDefault,
  }) = _AddressModel;

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);
}
