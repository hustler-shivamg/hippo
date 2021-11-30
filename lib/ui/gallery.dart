import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/utils/constants.dart';

class GalleryScreen extends StatelessWidget {
  List<GalleryImages>? images;

  GalleryScreen({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 49.h,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          width: 30.w,
                          height: 30.h,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/chevron.svg',
                              width: 12.w,
                              height: 20.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'pictures'.tr,
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 32.sp,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 37.w,
                      height: 37.h,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/close_icon.svg',
                          width: 37.w,
                          height: 37.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: images?.length ?? 0,
                padding: EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Image(
                    image: CachedNetworkImageProvider(
                      images?[index].image ?? "",
                    ),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
