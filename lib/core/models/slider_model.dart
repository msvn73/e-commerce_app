import 'package:freezed_annotation/freezed_annotation.dart';

part 'slider_model.freezed.dart';
part 'slider_model.g.dart';

@freezed
class SliderModel with _$SliderModel {
  const factory SliderModel({
    required String id,
    required String title,
    String? description,
    required String imageUrl,
    required String targetType, // 'category', 'product', 'page'
    String? targetId, // category id, product id, or page route
    String? targetUrl, // external URL
    @Default(true) bool isActive,
    @Default(0) int order,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _SliderModel;

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);
}
