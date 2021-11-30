import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/filter.dart';
import 'package:hippo/ui/kinderGardan/kinder_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';

class KindergardensScreen extends BaseView<KinderController> {
  ScrollController? _controller;
  bool visible = true;

  _scrollListener() {
    if (_controller!.offset <= _controller!.position.minScrollExtent + 60.h &&
        !_controller!.position.outOfRange) {
      //reach the top
      visible = true;
      controller.update();
    } else {
      visible = false;
      controller.update();
    }
  }
  @override
  Widget vBuilder(BuildContext context) {
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK) {
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: 177.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.26, 0.65),
                  end: Alignment(0.27, -1.0),
                  colors: [const Color(0xffffffff), const Color(0x4192e0ff)],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 49.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
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
                    Expanded(
                      child: Visibility(
                        visible: visible,
                        replacement: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 47.h,
                          child: Text(
                            "Kindergartens".tr,
                            style: AppTheme.details_title_bold2,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 47.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 11.w,
                              ),
                              SvgPicture.asset(
                                'assets/images/search_icon.svg',
                                width: 21.w,
                                height: 21.h,
                                fit: BoxFit.contain,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 4.h, left: 8.w, right: 8.w),
                                  child: TextField(
                                    maxLines: 1,
                                    minLines: 1,
                                    style: TextStyle(
                                        height: 1,
                                        fontFamily: Constants.FONT_ARIEN),
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      controller.searchData(value);
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    color: AppTheme.searchColor,
                                    width: 1.w,
                                    height: 47.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => FilterScreen()));
                                    },
                                    child: Container(
                                      width: 54.w,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/filter_icon.svg',
                                          width: 21.w,
                                          height: 21.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                            border: Border.all(
                                width: 1.0, color: const Color(0xffe3e3e3)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    controller: _controller,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 19.w),
                            child: Text(
                              "Kindergartens".tr,
                              style: AppTheme.details_title_bold,
                            ),
                          ),
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 18.h),
                          itemCount: controller.dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller.dataList[index];

                            return InkWell(
                              onTap: () {

                                var map = new Map<String, String>();
                                map["id"] = data.id.toString();
                                map["type"] = data.business == true
                                    ? "business"
                                    : "service_provider";
                                Get.toNamed(RouterName.kinderGardenDetailScreen,
                                    parameters: map);

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) =>
                                //             KinderGardenDetailScreen()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 175.h,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Align(
                                            child: Container(
                                              height: 49.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(5.r),
                                                  bottomLeft: Radius.circular(5.r),
                                                ),
                                                gradient: LinearGradient(
                                                  begin: Alignment(0.0, -1.0),
                                                  end: Alignment(0.0, 1.0),
                                                  colors: [
                                                    const Color(0x00000000),
                                                    const Color(0xd0000000)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.bottomCenter,
                                          ),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w, vertical: 12.h),
                                              child: Text(
                                                data.name ?? "",
                                                style: TextStyle(
                                                  fontFamily: Constants.FONT_ARIEN,
                                                  fontSize: 17.sp,
                                                  color: const Color(0xffffffff),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            alignment: Alignment.bottomLeft,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h, horizontal: 8.w),
                                                child: SvgPicture.asset(
                                                  data.isFavourite==true
                                                      ? 'assets/images/heart.svg'
                                                      : 'assets/images/heart_filled.svg',
                                                  width: 20.w,
                                                  height: 18.h,
                                                  fit: BoxFit.contain,
                                                )),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.r),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            data.businessLogo ?? "",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      [data.address, data.city, data.state]
                                          .where((element) =>
                                      element != null && element.isNotEmpty)
                                          .toList()
                                          .join(", "),
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 17.sp,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       '1700 / 120,000',
                                    //       style: TextStyle(
                                    //         fontFamily: Constants.FONT_ARIEN,
                                    //         fontSize: 10.sp,
                                    //         color: const Color(0xff707070),
                                    //       ),
                                    //       textAlign: TextAlign.left,
                                    //     ),
                                    //     SizedBox(
                                    //       width: 3.w,
                                    //     ),
                                    //     SvgPicture.asset(
                                    //       'assets/images/curruncy_icon.svg',
                                    //       width: 8.w,
                                    //       height: 8.h,
                                    //       fit: BoxFit.contain,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: const Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 10.r,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                thickness: 0.h,
                                height: 25.h,
                                color: const Color(0xffffffff),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
