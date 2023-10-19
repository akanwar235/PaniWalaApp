import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_cart_item_dto.freezed.dart';
part 'fetch_cart_item_dto.g.dart';

@freezed
class FetchCardItemDto with _$FetchCardItemDto{
  const FetchCardItemDto._();

  const factory FetchCardItemDto({
    required int userId,
    @Default("fetch")
     String type,
  }) = _FetchCardItemDto;

  factory FetchCardItemDto.fromJson(Map<String, dynamic> json) =>
      _$FetchCardItemDtoFromJson(json);
}
