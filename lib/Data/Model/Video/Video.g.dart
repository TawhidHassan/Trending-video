// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      json['thumbnail'] as String?,
      json['id'] as int?,
      json['title'] as String?,
      json['date_and_time'] == null
          ? null
          : DateTime.parse(json['date_and_time'] as String),
      json['slug'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['manifest'] as String?,
      json['live_status'] as int?,
      json['live_manifest'] as String?,
      json['is_live'] as bool?,
      json['channel_image'] as String?,
      json['channel_name'] as String?,
      json['channel_username'] as String?,
      json['is_verified'] as bool?,
      json['channel_slug'] as String?,
      json['channel_subscriber'] as String?,
      json['channel_id'] as int?,
      json['type'] as String?,
      json['viewers'] as String?,
      json['duration'] as String?,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'id': instance.id,
      'title': instance.title,
      'date_and_time': instance.dateAndTime?.toIso8601String(),
      'slug': instance.slug,
      'created_at': instance.createdAt?.toIso8601String(),
      'manifest': instance.manifest,
      'live_status': instance.liveStatus,
      'live_manifest': instance.liveManifest,
      'is_live': instance.isLive,
      'channel_image': instance.channelImage,
      'channel_name': instance.channelName,
      'channel_username': instance.channelUsername,
      'is_verified': instance.isVerified,
      'channel_slug': instance.channelSlug,
      'channel_subscriber': instance.channelSubscriber,
      'channel_id': instance.channelId,
      'type': instance.type,
      'viewers': instance.viewers,
      'duration': instance.duration,
    };
