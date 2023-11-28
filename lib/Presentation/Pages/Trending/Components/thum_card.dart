import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Data/Model/Video/Video.dart';
import '../../../../GetX Controller/TrendingController/TrendingController.dart';
import '../../../../custom_assets/assets.gen.dart';

class ThumCard extends StatelessWidget {
  final Video? video;
  const ThumCard({super.key, this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.find<TrendingController>().onInit();
        Navigator.pushNamed(context, VIDEO_DETAILS_PAGE,arguments: {
          "video":video
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        color: Colors.white,
        child: Column(
          children: [
          CachedNetworkImage(
          imageUrl: video!.thumbnail??"",
            errorWidget: (context, url, error) =>Container(
              width: 1.0.sw,
              height: 192,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.thumbnil.path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          placeholder: (context, url) =>CircularProgressIndicator(),
            imageBuilder: (context, image) => Container(
              width: 1.0.sw,
              height: 192,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(left: 17.0,right: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:1,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child:CachedNetworkImage(
                        imageUrl: video!.channelImage??"",
                        errorWidget: (context, url, error) =>CircleAvatar(
                          backgroundImage:AssetImage(Assets.icons.acount.path),
                          radius: 40,
                        ),
                        placeholder: (context, url) =>SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator()),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage:image,
                          radius: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    flex:8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video!.title??"",
                          style: TextStyle(
                            color: Color(0xFF1A202C),
                            fontSize: 15,
                            fontFamily: 'Hind Siliguri',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          '${video!.viewers} views  .   ${getCustomFormattedDateTime(video!.dateAndTime.toString()??"",'MMM dd, yyy')}',
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 11,),
                  Expanded(
                      flex:1,
                      child: Icon(Icons.more_vert,color: Color(0xFFD9D9D9))
                  )

                ],
              ),
            ),
            SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }


  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {

    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
    return docDateTime;
  }
}
