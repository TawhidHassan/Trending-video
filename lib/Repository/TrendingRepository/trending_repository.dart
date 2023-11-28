import 'package:clientproject/Data/Model/Video/VideoResponse.dart';
import 'package:logger/logger.dart';

import '../../Network/api_client.dart';

class TrendingRepository{
  final ApiClient apiClient;
  TrendingRepository({required this.apiClient});


 Future getCheck()async{
    apiClient.getData(uri: "target/last-sevenday-data");
    // apiClient.getData(uri: "target/last-sevenday-data",headers: {"xxx":"xxxx"});
  }

 Future<VideoResponse> getVideos(String limit, String page) async{
    final userRaw=await apiClient.getData(uri: "trending-video/$page?page=1");
    Logger().w(userRaw);
    return VideoResponse.fromJson(userRaw);
  }
}