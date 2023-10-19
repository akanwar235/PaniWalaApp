import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_model.freezed.dart';
part 'verify_otp_model.g.dart';

@freezed
class VerifyOtpModel with _$VerifyOtpModel {
  factory VerifyOtpModel({
    required String msg,
    required AccountDetails? accountDetails,
    required String? jwt,
  }) = _VerifyOtpModel;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpModelFromJson(json);
}

@freezed
class AccountDetails with _$AccountDetails {
  factory AccountDetails({
    @JsonKey(name: "accountDetails")
    required List<AccountDetailModel> accountDetailList,
    @JsonKey(name: "addressData")
    required List<AddressModel?> addressDataList,
  }) = _AccountDetails;

  factory AccountDetails.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsFromJson(json);
}

@freezed
class AccountDetailModel with _$AccountDetailModel {
  factory AccountDetailModel({
    @JsonKey(name: "id") required int userId,
    required int mobile,
    @JsonKey(name: "first_name") required String firstName,
    @JsonKey(name: "last_name") required String lastName,
    required String email,
    @JsonKey(name: "creation_date") required String creationDate,
  }) = _AccountDetailModel;

  factory AccountDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailModelFromJson(json);
}

@freezed
class AddressModel with _$AddressModel {
  factory AddressModel({
    @JsonKey(name: "id") required int addressId,
    @JsonKey(name: 'customer_id') required int customerId,
    required String latitude,
    required String longitude,
    @JsonKey(name: 'customer_name') required String customerName,
    required String? street,
    required String landmark,
    required String city,
    required String state,
    required int pincode,
    required int mobile,
    @JsonKey(name: 'addr_type') String? addrType,
    @JsonKey(name: 'isDefault') required String? isDefault,
    @JsonKey(name: 'house_no') required String? houseNo,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

VerifyOtpModel verifyOtpModelFromJson(String userDataStr) =>
    VerifyOtpModel.fromJson(json.decode(userDataStr));
