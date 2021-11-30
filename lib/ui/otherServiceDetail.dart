import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hippo/ui/addReview/add_review.dart';
import 'package:hippo/ui/gallery.dart';
import 'package:hippo/utils/constants.dart';

class OtherServiceDetailScreen extends StatefulWidget {
  @override
  _OtherServiceDetailScreenState createState() =>
      _OtherServiceDetailScreenState();
}

class _OtherServiceDetailScreenState extends State<OtherServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 312.h,
              child: Stack(
                children: [
                  Align(
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Container(
                        height: 103.h,
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
                    ),
                    alignment: Alignment.topCenter,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: SizedBox(
                      height: 35.h,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(left: 10.w),
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
                          Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/fav_service.svg',
                                  width: 29.w,
                                  height: 26.h,
                                  color: Colors.white,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => GalleryScreen(images: [],)));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/ic_gallery.svg',
                                    width: 26.w,
                                    height: 26.h,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/demo/kinder_demo_img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 63.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: const Color(0xFFF0F0F0),
                      child: Center(
                        child: SizedBox(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  'assets/images/ic_call.svg',
                                  width: 44.w,
                                  height: 44.h,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'Call'.tr,
                                style: TextStyle(
                                  fontFamily: Constants.FONT_ARIEN,
                                  fontSize: 20.sp,
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 3.w,
                  ),
                  Container(
                    color: const Color(0xFFF0F0F0),
                    child: SizedBox(
                      width: 108.w,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/ic_fb.svg',
                              width: 34.w,
                              height: 34.h,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_insta.svg',
                              width: 34.w,
                              height: 34.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Մուլտերի Աշխարհ',
                    style: TextStyle(
                      fontFamily: Constants.FONT_ARIEN,
                      fontSize: 24.sp,
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Մանկական Սրճարան',
                    style: TextStyle(
                      fontFamily: Constants.FONT_ARIEN,
                      fontSize: 14.sp,
                      color: const Color(0xffb9b9b9),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Halabyan 34a/1 (0.13 mi)\nYerevan, Armenia 0036',
                            style: TextStyle(
                              fontFamily: Constants.FONT_ARIEN,
                              fontSize: 17.sp,
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Image(
                          width: 88.w,
                          height: 80.h,
                          image: const AssetImage('assets/images/demo/map.png'),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 62.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tel'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xFF707070),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '(010) 349309',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 17.sp,
                                color: const Color(0xFF707070),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Մուլտերի Աշխարհ մանկական սրճարանի պրոֆեսիոնալ անձնակազմը հրավիրում է Ձեզ նշելու Ձեր փոքրիկի ցանկացած միջոցառումը մեզ մոտ:  Համեղ խոհանոց, մեծ խաղասրահ, 9D կինոթատրոն, շոու ծրագրեր, հաճելի երաժշտությունը Ձեր ուղեկիցը կլինեն միջոցառման ընթացքում: ',
                    style: TextStyle(
                      fontFamily: Constants.FONT_ARIEN,
                      fontSize: 14.sp,
                      color: const Color(0xff707070),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Center(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SvgPicture.asset(
                        'assets/images/chevron.svg',
                        width: 9.21.h,
                        height: 15.73.w,
                        color: Color(0xffB9B9B9),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 54.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'WorkingHours'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xFF707070),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '9:00 - 18:00',
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 17.sp,
                                color: const Color(0xff707070),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: SvgPicture.asset(
                                'assets/images/chevron.svg',
                                width: 7.w,
                                height: 12.h,
                                color: Color(0xffB9B9B9),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'opened'.tr,
                          style: TextStyle(
                            fontFamily: Constants.FONT_ARIEN,
                            fontSize: 17.sp,
                            color: const Color(0xff96c65f),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Text(
                    'PaymentTerms'.tr,
                    style: TextStyle(
                      fontFamily: Constants.FONT_ARIEN,
                      fontSize: 22.sp,
                      color: const Color(0xff0c6bc2),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'hourly'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 12.sp,
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '1700 դր',
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 20.sp,
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 63.4.h,
                        width: 1.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffe2e2e2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'daily'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 12.sp,
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '6000 դր',
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 20.sp,
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 63.4.h,
                        width: 1.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffe2e2e2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Monthly'.tr,
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 12.sp,
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '120,000 դր',
                                  style: TextStyle(
                                    fontFamily: Constants.FONT_ARIEN,
                                    fontSize: 20.sp,
                                    color: const Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffe2e2e2),
                    ),
                  ),
                  SizedBox(
                    height: 43.h,
                  ),
                ],
              ),
            ),
            Container(
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xff92e0ff),
              ),
            ),
            Container(
              color: const Color(0xffF0F0F0),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.w, top: 13.h, bottom: 13.h, right: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Reviews'.tr,
                              style: TextStyle(
                                  fontFamily: Constants.FONT_ARIEN,
                                  fontSize: 22.sp,
                                  color: const Color(0xff0c6bc2),
                                  fontWeight: FontWeight.w700,
                                  height: 1),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            RatingBar(
                              itemSize: 22.r,
                              ignoreGestures: true,
                              initialRating: 3,
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
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.5.w),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              '200',
                              style: TextStyle(
                                fontFamily: Constants.FONT_ARIEN,
                                fontSize: 10.0,
                                color: const Color(0xFF707070),
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddReviewScreen()));
                          },
                          child: SvgPicture.asset(
                            'assets/images/add_rating.svg',
                            width: 52.h,
                            height: 52.w,
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gurgen',
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 17.sp,
                          color: const Color(0xFF707070),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      RatingBar(
                        itemSize: 15.r,
                        ignoreGestures: true,
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(
                            'assets/images/heart_filled.svg',
                            color: Color(0xffB9B9B9),
                            fit: BoxFit.contain,
                          ),
                          half: SvgPicture.asset(
                            'assets/images/heart.svg',
                            color: Color(0xffB9B9B9),
                            fit: BoxFit.contain,
                          ),
                          empty: SvgPicture.asset(
                            'assets/images/fav_service.svg',
                            color: Color(0xffB9B9B9),
                            fit: BoxFit.contain,
                          ),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.5.w),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Text(
                        'Անչափ շնորհակալ եմ Բանգլադեշի մասնաճյուղի անձնակազմին ,ամեն ինչ շատ լավ էր կազմակերպված 🤗🤗🤗 Առանձնահատուկ շնորհակալություն մատուցողներին բարեհամբույր և համբերատար սպասարկման համար 👍👍👍👍 Մենք  մեր առիթները էլի կնշենք ձեզ մոտ 😊😊😊Շոուն էլ էր հոյակապ',
                        style: TextStyle(
                          fontFamily: Constants.FONT_ARIEN,
                          fontSize: 14.sp,
                          color: const Color(0xFF707070),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                thickness: 1.h,
                height: 32.h,
                color: const Color(0xffE2E2E2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
