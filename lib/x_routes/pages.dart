import 'package:get/get.dart';
import 'package:hippo/ui/addReview/add_review.dart';
import 'package:hippo/ui/addReview/add_review_binding.dart';
import 'package:hippo/ui/careGiver/caregiver_binding.dart';
import 'package:hippo/ui/careGiver/caregivers.dart';
import 'package:hippo/ui/caregiverDetail.dart';
import 'package:hippo/ui/dashboard/dashboard.dart';
import 'package:hippo/ui/dashboard/dashboard_binding.dart';
import 'package:hippo/ui/driver/driver_binding.dart';
import 'package:hippo/ui/driver/drivers.dart';
import 'package:hippo/ui/driverDetail.dart';
import 'package:hippo/ui/entertainment/entertainment.dart';
import 'package:hippo/ui/entertainment/entertainment_binding.dart';
import 'package:hippo/ui/home.dart';
import 'package:hippo/ui/kinderGardan/kinder_binding.dart';
import 'package:hippo/ui/kinderGardan/kindergardens.dart';
import 'package:hippo/ui/kindergardanDetail.dart';
import 'package:hippo/ui/login/forgot_binding.dart';
import 'package:hippo/ui/login/forgot_otp_verify.dart';
import 'package:hippo/ui/login/forgot_otp_verify_binding.dart';
import 'package:hippo/ui/login/forgot_password.dart';
import 'package:hippo/ui/login/login.dart';
import 'package:hippo/ui/login/login_binding.dart';
import 'package:hippo/ui/login/reset_passoword.dart';
import 'package:hippo/ui/login/reset_password_binding.dart';
import 'package:hippo/ui/myReviews/edit_review.dart';
import 'package:hippo/ui/myReviews/edit_review_binding.dart';
import 'package:hippo/ui/myReviews/my_reviews.dart';
import 'package:hippo/ui/myReviews/my_reviews_binding.dart';
import 'package:hippo/ui/myfav/my_fav.dart';
import 'package:hippo/ui/myfav/my_fav_binding.dart';
import 'package:hippo/ui/otherServices/other_service_binding.dart';
import 'package:hippo/ui/otherServices/other_services.dart';
import 'package:hippo/ui/pedia/pedia_binding.dart';
import 'package:hippo/ui/pedia/pediatricians.dart';
import 'package:hippo/ui/pediatricianDetail.dart';
import 'package:hippo/ui/personalDetail/personalDetail.dart';
import 'package:hippo/ui/personalDetail/personalDetail_binding.dart';
import 'package:hippo/ui/search/search.dart';
import 'package:hippo/ui/search/search_binding.dart';
import 'package:hippo/ui/serviceProviderList/service_provider_list_binding.dart';
import 'package:hippo/ui/serviceProviderList/serviceprovider_list.dart';
import 'package:hippo/ui/serviceProviderSignup/serviceProviderSignup.dart';
import 'package:hippo/ui/serviceProviderSignup/service_provider_signup_binding.dart';
import 'package:hippo/ui/signup/otp_verification.dart';
import 'package:hippo/ui/signup/otp_verification_binding.dart';
import 'package:hippo/ui/signup/signup.dart';
import 'package:hippo/ui/signup/signup_binding.dart';
import 'package:hippo/ui/test/test_binding.dart';
import 'package:hippo/ui/test/test_screen.dart';
import 'package:hippo/view_models/providerDetail/provider_detail_binding.dart';

import 'router_name.dart';

/**
 * Created by daewubintara on
 * 09, September 2020 09.07
 */

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
        name: RouterName.main_home,
        page: () => HomeScreen(),
      ),
      GetPage(
        name: RouterName.dashboard,
        page: () => DashboardScreen(),
        binding: BindingsBuilder(() {
          Get.put(DashboardController());
        }),
      ),
      GetPage(
          name: RouterName.test,
          page: () => TestScreen(),
          binding: TestBinding()),
      GetPage(
          name: RouterName.login,
          page: () => LoginScreen(),
          binding: LoginBinding()),
      GetPage(
          name: RouterName.forgotPassword,
          page: () => ForgotPassword(),
          binding: ForgotBinding()),
      GetPage(
          name: RouterName.caregiverList,
          page: () => CaregiversScreen(),
          binding: CaregiverBinding()),
      GetPage(
        name: RouterName.driverList,
        page: () => DriversScreen(),
        binding: DriverBinding(),
      ),
      GetPage(
        name: RouterName.kinderGardanList,
        page: () => KindergardensScreen(),
        binding: KinderBinding(),
      ),
      GetPage(
          name: RouterName.pediaList,
          page: () => PediatriciansScreen(),
          binding: PediaBinding()),
      GetPage(
        name: RouterName.entertermentList,
        page: () => EntertainmentScreen(),
        binding: EntertainmentBinding(),
      ),
      GetPage(
        name: RouterName.otherServiceList,
        page: () => OtherServicesScreen(),
        binding: OtherServicesBinding(),
      ),
      GetPage(
          name: RouterName.otpVerification,
          page: () => OTPVerificationScreen(),
          binding: OTPVerificationBinding()),
      GetPage(
          name: RouterName.resetPassword,
          page: () => ResetPasswordScreen(),
          binding: ResetPassBinding()),
      GetPage(
          name: RouterName.editReview,
          page: () => EditReviewScreen(),
          binding: EditReviewBinding()),
      GetPage(
          name: RouterName.forgotPasswordOTP,
          page: () => ForgotOTPVerificationScreen(),
          binding: ForgotOTPVerificationBinding()),
      GetPage(
          name: RouterName.signup,
          page: () => SignupScreen(),
          binding: SignupBinding()),
      GetPage(
          name: RouterName.personalDetail,
          page: () => PersonalDetail(),
          binding: PersonalDetailBinding()),
      GetPage(
          name: RouterName.caregiverDetail,
          page: () => CaregiverDetailScreen(),
          binding: ProviderDetailBinding()),
      GetPage(
          name: RouterName.driverDetail,
          page: () => DriverDetailScreen(),
          binding: ProviderDetailBinding()),
      GetPage(
          name: RouterName.pediatricianDetail,
          page: () => PediatricianDetailScreen(),
          binding: ProviderDetailBinding()),
      GetPage(
          name: RouterName.kinderGardenDetailScreen,
          page: () => KinderGardenDetailScreen(),
          binding: ProviderDetailBinding()),
      GetPage(
          name: RouterName.addReviewScreen,
          page: () => AddReviewScreen(),
          binding: AddReviewBinding()),
      GetPage(
          name: RouterName.serviceproviderSignup,
          page: () => ServiceProviderSignup(),
          binding: ServiceProviderSignupBinding()),
      GetPage(
          name: RouterName.myFav,
          page: () => MyFavScreen(),
          binding: MyFavBinding()),
      GetPage(
          name: RouterName.myReviews,
          page: () => MyReviewsScreen(),
          binding: MyReviewsBinding()),
      GetPage(
          name: RouterName.serviceProviderList,
          page: () => ServiceProviderListScreen(),
          binding: ServiceProviderListBinding()),
      GetPage(
          name: RouterName.search,
          page: () => SearchScreen(),
          binding: SearchBinding()),
    ];
  }
}
