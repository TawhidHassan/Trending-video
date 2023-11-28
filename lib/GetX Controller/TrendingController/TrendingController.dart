import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:clientproject/Data/Model/Video/Video.dart';
import 'package:clientproject/Data/Model/Video/VideoResponse.dart';
import 'package:clientproject/Repository/TrendingRepository/trending_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';


class TrendingController extends GetxController implements GetxService{

  final TrendingRepository? trendingRepository;


  TrendingController({this.trendingRepository});

  final currentIndex = 0.obs;
  final radius = 1.0.obs;

  final adress="Getting Location".obs;




  @override
  void onInit() {
    // TODO: implement onInit

    if(videoPlayerController!=null){
      videoPlayerController!.dispose();
      videoPlayerController=null;
    }


    super.onInit();
  }


  VideoPlayerController? videoPlayerController;
  final videoPlayCircle = false.obs;
  void playVideo(String url) {
    videoPlayCircle.value=true;

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        videoPlayCircle.value=false;
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    videoPlayerController!.play();
  }






  ///=========Feed with pagination========///////
  final circle = false.obs;
  final circuler = false.obs;
  List<Video> list = [];
  ScrollController controller = ScrollController();
  int listLength = 10;
  int page = 1;
  final orderPagingCirculer=false.obs;
  Rx<VideoResponse?>  videoResponse=Rx<VideoResponse?>(null);
  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        Logger().w("call");
        listLength++;
        page++;
        getFeedPagingData(page: page.toString());
        update();
      }
    });
  }

  Future<VideoResponse?>  getVideos({bool? isFirstr}) async{
    circuler.value=true;
    circle.value=true;
    list.clear();
    page=1;
    if(isFirstr!){
      addItems();
    }
    await trendingRepository?.getVideos(
        "10",
        '1',
      
    ).then((value) {
      circuler.value=false;
      circle.value=false;


        for(var i=0;i<value.results!.length;i++){
          list.add(value.results![i]);
        }

    });
  }

  getFeedPagingData({String? page}) async{
    orderPagingCirculer.value=true;
    await trendingRepository?.getVideos(
        "10",
        page!,
      
    ).then((value){
      for(var i=0;i<value.results!.length;i++){
        list.add(value.results![i]);
      }
      update();
      orderPagingCirculer.value=false;
    });

  }

///=========Feed with pagination========///////












}