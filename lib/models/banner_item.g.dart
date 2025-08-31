// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BannerItemImpl _$$BannerItemImplFromJson(Map<String, dynamic> json) =>
    _$BannerItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      actionUrl: json['actionUrl'] as String?,
    );

Map<String, dynamic> _$$BannerItemImplToJson(_$BannerItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'actionUrl': instance.actionUrl,
    };
