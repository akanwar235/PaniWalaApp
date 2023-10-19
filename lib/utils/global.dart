import 'package:water_order/models/verify_otp_model.dart';

abstract class VarGlobal {
  static bool isUserSignedIn = false;
  static double? currlati;
  static double? currlongi;

  ///user-Data
  static VerifyOtpModel? userData;

  ///account-details
  static AccountDetailModel accountDetailModel =
      userData!.accountDetails!.accountDetailList.first;
  static int userId = accountDetailModel.userId;
  static String userName =
      "${accountDetailModel.firstName} ${accountDetailModel.lastName}";
  static int userPhone = accountDetailModel.mobile;
  static String userEmail = accountDetailModel.email;

  ///addressData
  static AddressModel? addressModel =
      userData!.accountDetails!.addressDataList.first;
}
