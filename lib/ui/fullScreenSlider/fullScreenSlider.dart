import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/x_utils/widgets/slider_fullscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullScreenSlider extends StatefulWidget {
  List<GalleryImages> banners = [];
  int initialPage = 0;

  FullScreenSlider({Key? key, required this.banners, required this.initialPage})
      : super(key: key);

  @override
  _FullScreenSliderState createState() => _FullScreenSliderState();
}

class _FullScreenSliderState extends State<FullScreenSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            BannerSliderFullScreen(widget.banners, widget.initialPage),
            Stack(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
