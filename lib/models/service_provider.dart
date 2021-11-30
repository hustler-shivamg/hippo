class ServiceProvider {
  int? id;
  int? categoryId;
  int? subCategoryId;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? profilePic;
  String? city;
  int? cityId;
  String? state;
  String? postalCode;
  String? description;
  String? homePhone;
  String? cellPhone;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? pricePerHour;
  String? pricePerHourAmd;
  String? pricePerDay;
  String? pricePerDayAmd;
  String? pricePerMonth;
  String? pricePerMonthAmd;

  //Business Fields
  String? name;
  String? businessLogo;
  String? address;
  String? country;
  String? phoneNumber;
  String? emailAddress;
  String? website;
  List<GalleryImages>? images;
  bool? serviceProvider;
  bool? business;
  String? categoryName;
  String? subCategoryName;
  String? latitude;
  String? longitude;

  //Other
  int? smoker;
  int? haveKids;
  int? haveDrivingLicense;
  int? haveCar;
  int? drinker;
  bool? isFavourite;
  List<Reviews>? reviews;
  List<Hour>? hours;

  int? gender;
  String? educationNames;
  String? occupationNames;
  String? specialization;
  String? workExperienceNames;
  String? languageNames;
  int? verifyStatus;
  num? averageRating;
  num? reviewsCount;
  List<String>? workExperienceId;
  List<String>? educationId;

  ServiceProvider(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.profilePic,
      this.city,
      this.cityId,
      this.state,
      this.postalCode,
      this.description,
      this.homePhone,
      this.cellPhone,
      this.facebookUrl,
      this.instagramUrl,
      this.twitterUrl,
      this.pricePerHour,
      this.pricePerHourAmd,
      this.pricePerDayAmd,
      this.pricePerMonthAmd,
      this.workExperienceId,
      this.educationId,
      this.pricePerDay,
      this.pricePerMonth,
       });

  ServiceProvider.fromJson(dynamic json) {
    id = json["id"];
    categoryId = json["category_id"];
    subCategoryId = json["sub_category_id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    dateOfBirth = json["date_of_birth"];
    profilePic = json["profile_pic"];
    city = json["city"];
    cityId = json["city_id"];
    state = json["state"];
    postalCode = json["postal_code"];
    description = json["description"];
    homePhone = json["home_phone"];
    cellPhone = json["cell_phone"];
    facebookUrl = json["facebook_url"];
    instagramUrl = json["instagram_url"];
    twitterUrl = json["twitter_url"];
    pricePerHour = json["price_per_hour"];
    pricePerDay = json["price_per_day"];
    pricePerMonth = json["price_per_month"];
    pricePerHourAmd = json["price_per_hour_amd"];
    pricePerDayAmd = json["price_per_day_amd"];
    pricePerMonthAmd = json["price_per_month_amd"];
    latitude = json["location_latitude"];
    longitude = json["location_longitude"];
    workExperienceId = json["work_experience_id"] != null
        ? json["work_experience_id"].cast<String>()
        : [];
    educationId =
        json["education_id"] != null ? json["education_id"].cast<String>() : [];

    //Business
    //Business Fields
    name = json["name"];
    businessLogo = json["business_logo"];
    address = json["address"];
    country = json["country"];
    phoneNumber =
        json["phone_number"] ?? json["home_phone"] ?? json["cell_phone"];
    emailAddress = json["email_address"];
    website = json["website"];
    if (json["images"] != null) {
      images = [];
      json["images"].forEach((v) {
        images?.add(GalleryImages.fromJson(v));
      });
    }
    serviceProvider = json["service_provider"];
    business = json["business"];
    categoryName = json["category_name"];
    subCategoryName = json["sub_category_name"];

    //Other
    smoker = json["smoker"];
    haveKids = json["have_kids"];
    haveDrivingLicense = json["have_driving_license"];
    haveCar = json["have_car"];
    drinker = json["drinker"];
    isFavourite = json["is_favourite"];
    if (json["reviews"] != null) {
      reviews = [];
      json["reviews"].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    // hours = json["hours"] != null ? Hours.fromJson(json["hours"]) : null;
    if (json["hours"] != null) {
      print("shivam");
      hours = [];
      json["hours"].forEach((v) {
        hours?.add(Hour.fromJson(v));
      });
    }

    gender = json["gender"];
    educationNames = json["education_names"];
    occupationNames = json["occupation_names"];
    specialization = json["specialization"];
    workExperienceNames = json["work_experience_names"];
    languageNames = json["language_names"];
    verifyStatus = json["verify_status"];
    averageRating = json["average_rating"];
    reviewsCount = json["reviews_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["category_id"] = categoryId;
    map["sub_category_id"] = subCategoryId;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["date_of_birth"] = dateOfBirth;
    map["profile_pic"] = profilePic;
    map["city"] = city;
    map["city_id"] = cityId;
    map["state"] = state;
    map["postal_code"] = postalCode;
    map["description"] = description;
    map["home_phone"] = homePhone;
    map["cell_phone"] = cellPhone;
    map["facebook_url"] = facebookUrl;
    map["instagram_url"] = instagramUrl;
    map["twitter_url"] = twitterUrl;
    map["price_per_hour"] = pricePerHour;
    map["price_per_day"] = pricePerDay;
    map["price_per_month"] = pricePerMonth;
    map["location_latitude"] = latitude;
    map["location_longitude"] = longitude;
    map["price_per_hour_amd"] = pricePerHourAmd;
    map["price_per_day_amd"] = pricePerDayAmd;
    map["price_per_month_amd"] = pricePerMonthAmd;
    //Business
    map["name"] = name;
    map["business_logo"] = businessLogo;
    map["address"] = address;
    map["country"] = country;
    map["phone_number"] = phoneNumber;
    map["email_address"] = emailAddress;
    map["website"] = website;
    if (images != null) {
      map["images"] = images?.map((v) => v.toJson()).toList();
    }
    map["service_provider"] = serviceProvider;
    map["business"] = business;
    map["category_name"] = categoryName;
    map["sub_category_name"] = subCategoryName;

    //Other
    map["smoker"] = smoker;
    map["have_kids"] = haveKids;
    map["have_driving_license"] = haveDrivingLicense;
    map["have_car"] = haveCar;
    map["drinker"] = drinker;
    if (reviews != null) {
      map["reviews"] = reviews?.map((v) => v.toJson()).toList();
    }
    if (hours != null) {
      map["hours"] = hours?.map((v) => v.toJson()).toList();
    }
    // if (hours != null) {
    //   map["hours"] = hours?.toJson();
    // }

    map["gender"] = gender;
    map["education_names"] = educationNames;
    map["occupation_names"] = occupationNames;
    map["specialization"] = specialization;
    map["work_experience_names"] = workExperienceNames;
    map["language_names"] = languageNames;
    map["verify_status"] = verifyStatus;
    map["average_rating"] = averageRating;
    map["reviews_count"] = reviewsCount;
    map["education_id"] = educationId;
    map["work_experience_id"] = workExperienceId;
    return map;
  }
}

/// id : 1
/// business_id : 7
/// image : "http://3.228.39.224/hippo/public/storage/images/business/img_phps9bziG1622029190.png"
/// created_at : "2021-05-26T11:42:31.000000Z"
/// updated_at : "2021-05-26T11:42:31.000000Z"
class GalleryImages {
  int? id;
  int? businessId;
  String? image;
  String? createdAt;
  String? updatedAt;

  GalleryImages(
      {this.id, this.businessId, this.image, this.createdAt, this.updatedAt});

  GalleryImages.fromJson(dynamic json) {
    id = json["id"];
    businessId = json["business_id"];
    image = json["image"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["business_id"] = businessId;
    map["image"] = image;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}

/// id : 7
/// user_id : 1
/// service_id : 10
/// type : "business"
/// rating : 1
/// review_text : "Testing"
/// created_at : "2021-05-28T06:11:29.000000Z"
/// updated_at : "2021-05-28T06:11:29.000000Z"

class Reviews {
  int? id;
  int? userId;
  int? serviceId;
  String? type;
  int? rating;
  String? reviewText;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? businessName;

  Reviews(
      {this.id,
      this.userId,
      this.serviceId,
      this.type,
      this.rating,
      this.reviewText,
      this.createdAt,
      this.businessName,
      this.updatedAt});

  Reviews.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    serviceId = json["service_id"];
    type = json["type"];
    rating = json["rating"];
    reviewText = json["review_text"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    userName = json["user_name"] ?? "";

    if (json["business_name"] != null ||
        json["business_name"].toString().isNotEmpty) {
      businessName = json["business_name"];
    }
    if (json["service_provider_name"] != null ||
        json["service_provider_name"].toString().isNotEmpty) {
      businessName = json["service_provider_name"];
    }
   // businessName = json["business_name"] ?? json["service_provider_name"] ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["service_id"] = serviceId;
    map["type"] = type;
    map["rating"] = rating;
    map["review_text"] = reviewText;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["user_name"] = userName;
    map["business_name"] = businessName;
    return map;
  }
}

/// id : 28
/// business_id : 10
/// day_name : "friday"
/// open_hour : "12:00:00"
/// close_hour : "12:00:00"
/// created_at : "2021-05-27T08:29:23.000000Z"
/// updated_at : null
/// is_open : false

class Hour {
  Hour({
    this.id,
    this.businessId,
    this.dayName,
    this.openHour,
    this.closeHour,
    this.createdAt,
    this.updatedAt,
    this.isOpen,
    this.number,
  });

  int? id;
  int? businessId;
  String? dayName;
  String? openHour;
  String? closeHour;
  DateTime? createdAt;
  dynamic updatedAt;
  bool? isOpen;
  int? number;

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    id: json["id"] == null ? null : json["id"],
    businessId: json["business_id"] == null ? null : json["business_id"],
    dayName: json["day_name"] == null ? null : json["day_name"],
    openHour: json["open_hour"] == null ? null : json["open_hour"],
    closeHour: json["close_hour"] == null ? null : json["close_hour"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    isOpen: json["is_open"] == null ? null : json["is_open"],
    number: json["number"] == null ? null : json["number"],
  );

  // Hour.fromJson(dynamic json) {
  //   id = json["id"];
  //   businessId = json["business_id"];
  //   dayName = json["day_name"];
  //   openHour = json["open_hour"];
  //   closeHour = json["close_hour"];
  //   createdAt = json["created_at"];
  //   updatedAt = json["updated_at"];
  //   isOpen = json["is_open"];
  //   number = json["number"];
  //
  //   if (json["business_name"] != null ||
  //       json["business_name"].toString().isNotEmpty) {
  //     businessName = json["business_name"];
  //   }
  //   if (json["service_provider_name"] != null ||
  //       json["service_provider_name"].toString().isNotEmpty) {
  //     businessName = json["service_provider_name"];
  //   }
  //   // businessName = json["business_name"] ?? json["service_provider_name"] ?? "";
  // }

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "business_id": businessId == null ? null : businessId,
    "day_name": dayName == null ? null : dayName,
    "open_hour": openHour == null ? null : openHour,
    "close_hour": closeHour == null ? null : closeHour,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt,
    "is_open": isOpen == null ? null : isOpen,
    "number": number == null ? null : number,
  };

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map["id"] = id;
  //   map["business_id"] = businessId;
  //   map["day_name"] = dayName;
  //   map["open_hour"] = openHour;
  //   map["close_hour"] = closeHour;
  //   map["created_at"] = createdAt;
  //   map["updated_at"] = updatedAt;
  //   map["is_open"] = isOpen;
  //   map["number"] = number;
  //   return map;
  // }
}


// class Hours {
//   int? id;
//   int? businessId;
//   String? dayName;
//   String? openHour;
//   String? closeHour;
//   String? createdAt;
//   dynamic? updatedAt;
//   bool? isOpen;
//
//   Hours(
//       {this.id,
//       this.businessId,
//       this.dayName,
//       this.openHour,
//       this.closeHour,
//       this.createdAt,
//       this.updatedAt,
//       this.isOpen});
//
//   Hours.fromJson(dynamic json) {
//     id = json["id"];
//     businessId = json["business_id"];
//     dayName = json["day_name"];
//     openHour = json["open_hour"];
//     closeHour = json["close_hour"];
//     createdAt = json["created_at"];
//     updatedAt = json["updated_at"];
//     isOpen = json["is_open"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = id;
//     map["business_id"] = businessId;
//     map["day_name"] = dayName;
//     map["open_hour"] = openHour;
//     map["close_hour"] = closeHour;
//     map["created_at"] = createdAt;
//     map["updated_at"] = updatedAt;
//     map["is_open"] = isOpen;
//     return map;
//   }
// }
