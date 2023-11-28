import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clientproject/Data/Model/Video/Video.dart';
import 'package:clientproject/GetX%20Controller/TrendingController/TrendingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/TextField/icon_bg_textfield.dart';
import 'Components/thum_card.dart';
import 'Components/video_controller.dart';


class VideoDetailsPage extends StatefulWidget {
  final Video? video;

  const VideoDetailsPage({Key? key, this.video}) : super(key: key);

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {


  @override
  void dispose() {
    // TODO: implement dispose
    Logger().w("cccc");
    var controller=Get.find<TrendingController>();
    if(controller.videoPlayerController!.value.isPlaying){
      controller.videoPlayerController!.pause();
      controller.videoPlayerController!.dispose();

    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.find<TrendingController>().onInit();
    });
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      body: GetBuilder<TrendingController>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(
              height: 1.0.sh,
              width: 1.0.sw,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: ListView(
                children: [
                  controller.videoPlayCircle.value
                      ?
                  SizedBox(
                      height: 100,
                      width: 30,
                      child: Center(child: CircularProgressIndicator(),))
                      :
                  controller.videoPlayerController == null ?
                  CachedNetworkImage(
                    imageUrl: widget.video!.thumbnail ?? "",
                    errorWidget: (context, url, error) =>
                        Container(
                          width: 1.0.sw,
                          height: 211,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.images.thumbnil.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageBuilder: (context, image) =>
                        Container(
                          width: 1.0.sw,
                          height: 211,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  controller.playVideo(widget.video!.manifest ?? "");
                                },
                                child:
                                Icon(
                                  Icons.play_arrow, color: Colors.blueGrey,
                                  size: 100,)),
                          ),
                        ),
                  ) : controller.videoPlayerController!.value.isInitialized ?

                  AspectRatio(
                    aspectRatio: controller.videoPlayerController!.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(controller.videoPlayerController!),
                        ClosedCaption(text: controller.videoPlayerController!.value.caption.text),

                        ControlsOverlay(controller: controller.videoPlayerController!),
                        VideoProgressIndicator(padding: EdgeInsets.all(12),controller.videoPlayerController!, allowScrubbing: true),
                      ],
                    ),
                  ):
                  // AspectRatio(
                  //   aspectRatio: controller.videoPlayerController!.value
                  //       .aspectRatio,
                  //   child: VideoPlayer(controller.videoPlayerController!),
                  // ) :
                  CachedNetworkImage(
                    imageUrl: widget.video!.thumbnail ?? "",
                    errorWidget: (context, url, error) =>
                        Container(
                          width: 1.0.sw,
                          height: 211,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.images.thumbnil.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageBuilder: (context, image) =>
                        Container(
                          width: 1.0.sw,
                          height: 211,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  controller.playVideo(widget.video!.manifest ?? "");
                                },
                                child: controller.videoPlayCircle.value
                                    ? CircularProgressIndicator()
                                    :
                                Icon(
                                  Icons.play_arrow, color: Colors.blueGrey,
                                  size: 100,)),
                          ),
                        ),
                  ),

                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.video!.title ?? "",
                          style: TextStyle(
                            color: Color(0xFF1A202C),
                            fontSize: 15,
                            fontFamily: 'Hind Siliguri',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${widget.video!.viewers} views',
                                style: TextStyle(
                                  color: Color(0xFF718096),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '  ',
                                style: TextStyle(
                                  color: Color(0xFF72767B),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '.   ${timeAgo(getCustomFormattedDateTime(
                                    widget.video!.dateAndTime!.toLocal().toString() ??
                                        "", 'MM-dd-yyy h:mm a'))}',
                                style: TextStyle(
                                  color: Color(0xFF718096),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFE2E8F0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Assets.icons.heart.svg(),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Mash Allah',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '  ',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                        TextSpan(
                                          text: '(12k)',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFE2E8F0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Assets.icons.like.svg(),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Like',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '  ',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                        TextSpan(
                                          text: '(12k)',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFE2E8F0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Assets.icons.share.svg(),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Share',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFE2E8F0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Assets.icons.report.svg(),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'report',
                                          style: TextStyle(
                                            color: Color(0xFF718096),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CachedNetworkImage(
                                  imageUrl: widget.video!.channelImage ?? "",
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            Assets.icons.acount.path),
                                        radius: 40,
                                      ),
                                  placeholder: (context, url) =>
                                      SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator()),
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                        backgroundImage: image,
                                        radius: 40,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.video!.channelName ?? "",
                                      style: TextStyle(
                                        color: Color(0xFF1A202C),
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${widget.video!.channelSubscriber} Subscribers',
                                      style: TextStyle(
                                        color: Color(0xFF718096),
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.22,
                                      ),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 12, right: 14, bottom: 8),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF3898FC),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons.add, color: Colors.white,),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Subscribe',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0.12,
                                                letterSpacing: -0.24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16,),
                  Container(
                    width: 1.0.sw,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Comments   7.5K',
                              style: TextStyle(
                                color: Color(0xFF718096),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,

                              ),
                            ),
                            Assets.icons.arrowupdowon.svg()
                          ],
                        ),
                        SizedBox(height: 8,),
                        IconBackgroundTextfield(
                          controller: null,
                          height: 16,
                          iconsLats: true,
                          borderRadius: 6,
                          hintText: "Add Comment",
                          icons: Assets.icons.send.path,
                          readOnly: false,
                          isNumber: false,

                          borderColor: Color(0xFFE2E8F0),
                        ),
                        SizedBox(height: 16,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      Assets.icons.acount.path),
                                  radius: 40,
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                                flex: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Fahmida khanom    ',
                                            style: TextStyle(
                                              color: Color(0xFF718096),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "1 Days ago",
                                            style: TextStyle(
                                              color: Color(0xFF718096),
                                              fontSize: 8,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 7,),
                                    SizedBox(
                                      width: 306,
                                      child: Text(
                                        'হুজুরের বক্তব্য গুলো ইংরেজি তে অনুবাদ করে সারা পৃথিবীর মানুষদের কে শুনিয়ে দিতে হবে। কথা গুলো খুব দামি',
                                        style: TextStyle(
                                          color: Color(0xFF4A5568),
                                          fontSize: 12,
                                          fontFamily: 'Hind Siliguri',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    width: 1.0.sw,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          });
        },
      ),

    );
  }

  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    // var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(givenDateTime, true);
    // var local = date.toLocal().toString();
    // // print(local);
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    // return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1
          ? "year"
          : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1
          ? "month"
          : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1
          ? "week"
          : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1
          ? "minute"
          : "minutes"} ago";
    return "just now";
  }
}




