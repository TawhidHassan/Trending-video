import 'dart:async';

import 'package:clientproject/GetX%20Controller/TrendingController/TrendingController.dart';
import 'package:clientproject/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import 'Components/thum_card.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.find<TrendingController>().getVideos(isFirstr: true);
    });
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Trending Videos',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,

          ),
        ),
      ),
      body: GetBuilder<TrendingController>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(
              height: 1.0.sh,
              width: 1.0.sw,
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              child: controller.circuler.value ? LoadingWidget() :
              controller.list.isEmpty ? Center(child: Text("There has no data"),) :
              ListView.builder(
                controller: controller.controller,
                itemCount: controller.list.length + (controller.orderPagingCirculer.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.list.length) {
                    return ThumCard(video: controller.list[index],);
                  }else{
                    Timer(const Duration(milliseconds: 30), () {
                      controller.controller.jumpTo(
                          controller.controller.position.maxScrollExtent
                      );
                    });
                    return const Center(
                      child: CircularProgressIndicator(),);
                  }
                },
              ),
            );
          });
        },
      ),

    );
  }
}



