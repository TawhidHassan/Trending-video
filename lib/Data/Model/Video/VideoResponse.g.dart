// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoResponse _$VideoResponseFromJson(Map<String, dynamic> json) =>
    VideoResponse(
      json['total'] as int?,
      json['page'] as int?,
      json['page_size'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoResponseToJson(VideoResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.pageSize,
      'results': instance.results,
    };
