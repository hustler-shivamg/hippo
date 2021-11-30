import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hippo/models/service_provider.dart';
import 'package:hippo/ui/fullScreenSlider/fullScreenSlider.dart';
import 'package:hippo/utils/constants.dart';

class BannerSlider extends StatefulWidget {
  final List<GalleryImages> banners;

  BannerSlider(this.banners);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

int _current = 0;
int _selectedIndex = 0;

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 412.h,
            aspectRatio: 1.48,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 6),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              _current = index;
               setState(() {});
            },
          ),
          items: widget.banners.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenSlider(
                          banners: widget.banners,
                          initialPage: _current,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: banner.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Container(
          height: 312.h,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color:  Colors.black,
              ),
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
              margin: EdgeInsets.only(bottom: 20.h),
              child: Text(
                "${_current+1} of ${widget.banners.length}",
                style: TextStyle(
                  fontFamily: Constants.FONT_ARIEN,
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
