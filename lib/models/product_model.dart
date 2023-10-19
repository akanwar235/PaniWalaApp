import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
     int? id,
     String? product_name,
     String? product_desc,
     int? brand_id,
     String? category,
     String? subcategory,
     double? mrp,
     double? disc_price,
     double? disc_percent,
     String? hsn,
     double? gst_percent,
     String? image1,
     String? image2,
     String? image3,
     String? image4,
     String? image5,
     int? packOf,
     String? barcode,
     int? admin_id,
     String? status,
     String ?brand_desc,
     String? logo,
     String? brand_name,
     int? store_id,
     int? product_id,
     int? quantity_left,
     int? total_quantity,
     @Default(0)
     int quantity
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

List<ProductModel> listProductModelFromJson(List jsonList) =>
    List<ProductModel>.from(
        jsonList.map((x) => ProductModel.fromJson(x)));

String listProductModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
