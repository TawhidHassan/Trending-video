// ignore_for_file: file_names
import 'package:clientproject/Data/Model/Video/Video.dart';
import 'package:json_annotation/json_annotation.dart';



part 'VideoResponse.g.dart';

@JsonSerializable()
class VideoResponse{




  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "page_size")
  int? pageSize;
  @JsonKey(name: "results")
  List<Video>? results;


  VideoResponse(this.total, this.page, this.pageSize, this.results);

  factory VideoResponse.fromJson(Map<String,dynamic>json)=>
      _$VideoResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$VideoResponseToJson(this);
}