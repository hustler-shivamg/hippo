import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/ui/filter.dart';
import 'package:hippo/ui/kinderGardan/kinder_binding.dart';
import 'package:hippo/ui/serviceProviderList/service_provider_list_binding.dart';
import 'package:hippo/utils/constants.dart';
import 'package:hippo/utils/styling.dart';

class ServiceProviderListScreen
    extends BaseView<ServiceProviderListController> {
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
      return SingleChildScrollView(
        physics: new ClampingScrollPhysics(),
        child: Container(
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
                  Container(
                    height: 108.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/images/inner_bg.svg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.only(bottom: 18.h),
                            child: Row(
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
                                        height: 20.5.h,
                                        color: Colors.white,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      controller.title ?? "",
                                      style: AppTheme.dashboard_title_new,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // FilterData? filterData = await Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => FilterScreen(
                                    //           educations: controller.educations,
                                    //           workExperiences:
                                    //           controller.workExperiences,
                                    //           age: controller.age,
                                    //           filterData: controller.filterData,
                                    //         )));
                                    //
                                    // if (filterData != null) {
                                    //   if (filterData.isReset == false) {
                                    //     controller.applyFilter(filterData);
                                    //   } else {
                                    //     controller.resetList();
                                    //   }
                                    // }
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
                                        width: 24.w,
                                        color: Colors.white,
                                        height: 21.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  controller.cities?.length != 0 ?
                  Container(
                    height: 58.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: double.infinity,
                    color: const Color(0xffF0F0F0),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        // physics: new ClampingScrollPhysics(),
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.cities?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var data = controller.cities != null
                              ? controller.cities![index]
                              : null;
                          return Center(
                            child: InkWell(
                              onTap: () {
                                controller.searchCityWise(data?.id);
                              },
                              child: Container(
                                height: 35.h,
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      data?.name ?? "",
                                      style: TextStyle(
                                        fontFamily: Constants.FONT_ARIEN,
                                        fontSize: 13.sp,
                                        color: controller.selectedCityId == data?.id?Colors.white: Color(0xFF707070),
                                        letterSpacing: -0.26,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: controller.selectedCityId == data?.id
                                      ?  Color(0xFF92e0ff)
                                      : Colors.white,
                                  border: Border.all(
                                    width: 1.r,
                                    color: const Color(0xFFE6E6E6),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                      :
                  Container(),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          left: 10.w,top: 20.h,right: 10.w
                        ),
                        // physics: new ClampingScrollPhysics(),
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        // padding: EdgeInsets.symmetric(vertical: 20.h,),
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
                              // padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data.images != null && data.images!.isNotEmpty
                                      ? SizedBox(
                                          height: 115.w,
                                          child: ListView.separated(
                                              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                              // physics: new ClampingScrollPhysics(),
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      Container(
                                                        width: 6.w,
                                                      ),
                                              // shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: data.images?.length ?? 0,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Container(
                                                  height: 114.w,
                                                  width: 114.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5.r),
                                                    image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        data.images?[index].image ??
                                                            "",
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      : Container(
                                          height: 115.w,
                                          width: double.infinity,
                                          child: Image(
                                            image: const AssetImage(
                                                'assets/images/no_image.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  // Container(
                                  //   height: 115.h,
                                  //   width: 115.h,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(5.r),
                                  //     image: DecorationImage(
                                  //       image: CachedNetworkImageProvider(
                                  //         data.businessLogo ?? "",
                                  //       ),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    data.name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 18.sp,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        RatingBar(
                                          itemSize: 16.r,
                                          ignoreGestures: true,
                                          initialRating:
                                              data.averageRating?.toDouble() ?? 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          ratingWidget: RatingWidget(
                                            full: SvgPicture.asset(
                                              'assets/images/heart_filled.svg',
                                              color: Color(0xffFF7BAC),
                                              fit: BoxFit.contain,
                                            ),
                                            half: SvgPicture.asset(
                                              'assets/images/heart.svg',
                                              color: Color(0xffFF7BAC),
                                              fit: BoxFit.contain,
                                            ),
                                            empty: SvgPicture.asset(
                                              'assets/images/fav_service.svg',
                                              color: Color(0xffFF7BAC),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.5.w),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          (data.reviewsCount ?? 0).toString(),
                                          style: TextStyle(
                                            fontFamily: Constants.FONT_ARIEN,
                                            fontSize: 18.sp,
                                            color: const Color(0xFF757280),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    [data.city, data.state]
                                        .where((element) =>
                                            element != null && element.isNotEmpty)
                                        .toList()
                                        .join(", "),
                                    style: TextStyle(
                                      fontFamily: Constants.FONT_ARIEN,
                                      fontSize: 14.sp,
                                      color: const Color(0xff757280),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          height: 13.h,
                          color: const Color(0xffF4F4F4),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
