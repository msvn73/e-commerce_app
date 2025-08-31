import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    String? description,
    String? iconName,
    String? color,
    String? imageUrl,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
