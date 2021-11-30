import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/models/filter_data.dart';
import 'package:hippo/ui/driver/driver_binding.dart';
import 'package:hippo/ui/driverDetail.dart';
import 'package:hippo/ui/filter.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';
import 'package:hippo/x_utils/utilities.dart';

class DriversScreen extends BaseView<DriverController> {

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
        height: MediaQuery
            .of(context)
            .size
            .height,
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
                            "Drivers".tr,
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
                                    decoration:
                                    InputDecoration(border: InputBorder.none),
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
                                    onTap: () async {
                                      FilterData? filterData =
                                          await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => FilterScreen(
                                                educations: controller
                                                    .educations,
                                                workExperiences:
                                                controller
                                                    .workExperiences,
                                                age: controller.age,
                                                filterData: controller
                                                    .filterData,
                                              )));

                                      if (filterData != null) {
                                        if (filterData.isReset == false) {
                                          controller.applyFilter(filterData);
                                        }else{
                                          controller.resetList();
                                        }
                                      }
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
                  height: 40.h,
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
                              "Drivers".tr,
                              style: AppTheme.details_title_bold,
                            ),
                          ),
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 18.w, right: 18.w, top: 25.h, bottom: 18.h),
                          itemCount: controller.dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller.dataList[index];

                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => DriverDetailScreen()));
                                var map = new Map<String, String>();
                                map["id"] = data.id.toString();
                                map["type"] = data.business == true
                                    ? "business"
                                    : "service_provider";
                                Get.toNamed(RouterName.driverDetail,
                                    parameters: map);

                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Adobe XD layer: 'Screen Shot 2019-07…' (shape)
                                  Container(
                                    width: 110.w,
                                    height: 110.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      image: DecorationImage(
                                        image:CachedNetworkImageProvider(
                                          data.profilePic ?? "",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                          width: 1.r,
                                          color: const Color(0x39707070)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "${data.firstName ?? ""} ${data.lastName ?? ""}"
                                                .trim(),
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 22.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "${Utilities().getAge(data.dateOfBirth ?? "")}"+" " +
                                                "Years".tr,
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 16.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Ընդհանուր' +
                                                "\n${data.city != null ? data.city! + ", " : ""}${data.state ?? ""}"
                                                    .trimRight(),
                                            style: TextStyle(
                                              fontFamily: Constants.FONT_ARIEN,
                                              fontSize: 14.sp,
                                              color: const Color(0xff707070),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${data.pricePerHour != null ? "${data.pricePerHour} / " : ""}" +
                                                    "${data.pricePerDay != null ? "${data.pricePerDay} / " : ""}" +
                                                    "${data.pricePerMonth != null ? "${data.pricePerMonth}" : ""}",
                                                style: TextStyle(
                                                  fontFamily: Constants
                                                      .FONT_ARIEN,
                                                  fontSize: 10.sp,
                                                  color: const Color(
                                                      0xff707070),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/curruncy_icon.svg',
                                                width: 8.w,
                                                height: 8.h,
                                                fit: BoxFit.contain,
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                thickness: 1.h,
                                height: 32.h,
                                color: const Color(0xffE2E2E2),
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
