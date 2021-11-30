import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hippo/models/service_provider.dart';

class BannerSliderFullScreen extends StatefulWidget {
  final List<GalleryImages> banners;
  int initialPage = 0;

  BannerSliderFullScreen(this.banners, this.initialPage);

  @override
  _BannerSliderFullScreenState createState() => _BannerSliderFullScreenState();
}

int _current = 0;
int _selectedIndex = 0;

class _BannerSliderFullScreenState extends State<BannerSliderFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1,
            initialPage: widget.initialPage,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 6),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              _current = index;
              // setState(() {});
            },
          ),
          items: widget.banners.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: banner.image ?? "",
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        // Container(
        //   height: 312.h,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: widget.banners.map((url) {
        //         int index = widget.banners.indexOf(url);
        //         // print(_current);
        //         // print(_current == index);
        //
        //         return Container(
        //           width: 10.w,
        //           height: 10.w,
        //           margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: _current == index
        //                 ? Color(0xFF707070)
        //                 : Color(0xFFDFDEDE),
        //             border: Border.all(
        //               width: 1.w,
        //               color: const Color(0xFF707070),
        //             ),
        //           ),
        //         );
        //       }).toList(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
