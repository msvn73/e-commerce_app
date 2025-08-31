import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_item.freezed.dart';
part 'banner_item.g.dart';

@freezed
class BannerItem with _$BannerItem {
  const factory BannerItem({
    required String id,
    required String title,
    required String subtitle,
    required String imageUrl,
    String? actionUrl,
  }) = _BannerItem;

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);
}
