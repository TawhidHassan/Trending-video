// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';
part 'Video.g.dart';

@JsonSerializable()
class Video{

   @JsonKey(name: "thumbnail")
   String? thumbnail;
   @JsonKey(name: "id")
   int? id;
   @JsonKey(name: "title")
   String? title;
   @JsonKey(name: "date_and_time")
   DateTime? dateAndTime;
   @JsonKey(name: "slug")
   String? slug;
   @JsonKey(name: "created_at")
   DateTime? createdAt;
   @JsonKey(name: "manifest")
   String? manifest;
   @JsonKey(name: "live_status")
   int? liveStatus;
   @JsonKey(name: "live_manifest")
   String? liveManifest;
   @JsonKey(name: "is_live")
   bool? isLive;
   @JsonKey(name: "channel_image")
   String? channelImage;
   @JsonKey(name: "channel_name")
   String? channelName;
   @JsonKey(name: "channel_username")
   String? channelUsername;
   @JsonKey(name: "is_verified")
   bool? isVerified;
   @JsonKey(name: "channel_slug")
   String? channelSlug;
   @JsonKey(name: "channel_subscriber")
   String? channelSubscriber;
   @JsonKey(name: "channel_id")
   int? channelId;
   @JsonKey(name: "type")
   String? type;
   @JsonKey(name: "viewers")
   String? viewers;
   @JsonKey(name: "duration")
   String? duration;


   Video(
      this.thumbnail,
      this.id,
      this.title,
      this.dateAndTime,
      this.slug,
      this.createdAt,
      this.manifest,
      this.liveStatus,
      this.liveManifest,
      this.isLive,
      this.channelImage,
      this.channelName,
      this.channelUsername,
      this.isVerified,
      this.channelSlug,
      this.channelSubscriber,
      this.channelId,
      this.type,
      this.viewers,
      this.duration);

  factory Video.fromJson(Map<String,dynamic>json)=>
       _$VideoFromJson(json);
   Map<String,dynamic>toJson()=>_$VideoToJson(this);
}