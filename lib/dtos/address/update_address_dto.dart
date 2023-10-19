import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_address_dto.freezed.dart';
part 'update_address_dto.g.dart';

@freezed
class UpdateAddressDto with _$UpdateAddressDto {
  factory UpdateAddressDto({
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
    @JsonKey(name: 'addressId') required String addressId
  }) = _AddressModel;

  factory UpdateAddressDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateAddressDtoFromJson(json);
}
