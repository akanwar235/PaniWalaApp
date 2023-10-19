// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_order/dtos/create_user_dto.dart';
// import 'package:water_order/dtos/get_product_list_dto.dart';
// import 'package:water_order/models/get_product_list_response_model.dart';

// final userProvier =
//     StateNotifierProvider<UserNotifier, GetProductListResponseModel>(
//         (ref) => UserNotifier());

// class UserNotifier extends StateNotifier<CreateUserDto> {
//   // UserNotifier(super.state);
//   var dto = CreateUserDto(
//       phone: "phone",
//       firstName: "firstName",
//       lastName: "lastName",
//       email: "email");
//   UserNotifier(this.dto) : super(state);

//   void updateProductName(String n) {
//     state = state.copyWith(name: n);
//   }
// }
