import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_product_list_dto.freezed.dart';
part 'get_product_list_dto.g.dart';

@freezed
class GetProductListDto with _$GetProductListDto {
  const GetProductListDto._();

  const factory GetProductListDto({
    required String lat1,
    required String long,
  }) = _GetProductListDto;

  factory GetProductListDto.fromJson(Map<String, dynamic> json) =>
      _$GetProductListDtoFromJson(json);
}
