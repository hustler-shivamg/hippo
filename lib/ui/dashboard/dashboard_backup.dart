import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippo/base/base_controller.dart';
import 'package:hippo/base/base_view_view_model.dart';
import 'package:hippo/r.g.dart';
import 'package:hippo/ui/careGiver/caregivers.dart';
import 'package:hippo/ui/dashboard/dashboard_binding.dart';
import 'package:hippo/ui/driver/drivers.dart';
import 'package:hippo/ui/entertainment/entertainment.dart';
import 'package:hippo/ui/kinderGardan/kindergardens.dart';
import 'package:hippo/ui/otherServices/other_services.dart';
import 'package:hippo/ui/pedia/pediatricians.dart';
import 'package:hippo/ui/signup/signup.dart';
import 'package:hippo/utils/styling.dart';



class DashboardBackupScreen extends BaseView<DashboardController> {
  @override
  Widget vBuilder(BuildContext context) {
    return _body(context);
  }

  _body(BuildContext context) {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());
    if (controller.screenStateIsError) return Text(XR().string.error_message);
    if (controller.screenStateIsOK)
      return Scaffold(
        body: Stack(
          children: [
            Container(
              child: SvgPicture.asset(
                'assets/images/dashboard_bg.svg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 81.h,
                    ),
                    Center(
                      child: Image(
                        image: R.image.dashboard_logo(),
                        height: 120.h,
                        width: 108.w,
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),


                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CaregiversScreen()));
                      },
                      child: Container(
                        width: 334.w,
                        height: 75.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_caregiver.svg',
                              height: 43.h,
                              width: 43.w,
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              "Caregivers",
                              style: AppTheme.dashboard_title,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => KindergardensScreen()));
                      },
                      child: Container(
                        width: 334.w,
                        height: 75.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_kindergardens.svg',
                              height: 43.h,
                              width: 43.w,
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              "Kindergardens",
                              style: AppTheme.dashboard_title,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PediatriciansScreen()));
                      },
                      child: Container(
                        width: 334.w,
                        height: 75.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_pediatricians.svg',
                              height: 43.h,
                              width: 43.w,
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              "Pediatricians",
                              style: AppTheme.dashboard_title,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => DriversScreen()));
                      },
                      child: Container(
                        width: 334.w,
                        height: 75.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_drivers.svg',
                              height: 43.h,
                              width: 43.w,
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              "Drivers",
                              style: AppTheme.dashboard_title,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EntertainmentScreen()));
                      },
                      child: Container(
                        width: 334.w,
                        height: 75.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_entertainment.svg',
                              height: 43.h,
                              width: 43.w,
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              "Entertainment",
                              style: AppTheme.dashboard_title,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    InkWell(
                      child: Container(
                        width: 334.w,
                        height: 75.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/ic_other.svg',
                              height: 43.h,
                              width: 43.w,
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              "Other Services",
                              style: AppTheme.dashboard_title,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => OtherServicesScreen()));
                      },
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupScreen()));
                          },
                          child: Text(
                            "Sign-up",
                            style: AppTheme.dashboard_title_underline,
                          ),
                        ),
                        SizedBox(
                          width: 60.w,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouterName.login);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: AppTheme.dashboard_title_underline,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
