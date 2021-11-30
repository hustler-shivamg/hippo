// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString?);

import 'dart:convert';

class User {
  User({
    this.id,
    this.enFirstName,
    this.armFirstName,
    this.enLastName,
    this.armLastName,
    this.email,
    this.categoryId,
    this.subCategoryId,
    this.dateOfBirth,
    this.gender,
    this.profilePic,
    this.city,
    this.state,
    this.postalCode,
    this.enDescription,
    this.armDescription,
    this.homePhone,
    this.cellPhone,
    this.facebookUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.enEducation,
    this.armEducation,
    this.educationId,
    this.occupationId,
    this.enWorkExperience,
    this.armWorkExperience,
    this.workExperienceId,
    this.language,
    this.pricePerHour,
    this.pricePerDay,
    this.pricePerMonth,
    this.smoker,
    this.haveKids,
    this.haveDrivingLicense,
    this.haveCar,
    this.drinker,
    this.serviceProvider,
    this.verifyStatus,
    this.status,
    this.apiToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? enFirstName;
  dynamic armFirstName;
  String? enLastName;
  dynamic armLastName;
  String? email;
  int? categoryId;
  int? subCategoryId;
  String? dateOfBirth;
  int? gender;
  String? profilePic;
  String? city;
  String? state;
  String? postalCode;
  String? enDescription;
  dynamic armDescription;
  String? homePhone;
  String? cellPhone;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? enEducation;
  dynamic armEducation;
  String? educationId;
  String? occupationId;
  String? enWorkExperience;
  dynamic armWorkExperience;
  String? workExperienceId;
  String? language;
  String? pricePerHour;
  String? pricePerDay;
  String? pricePerMonth;
  int? smoker;
  int? haveKids;
  int? haveDrivingLicense;
  int? haveCar;
  int? drinker;
  int? serviceProvider;
  int? verifyStatus;
  int? status;
  String? apiToken;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory User.fromJson(Map<String?, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        enFirstName:
            json["en_first_name"] == null ? null : json["en_first_name"],
        armFirstName: json["arm_first_name"],
        enLastName: json["en_last_name"] == null ? null : json["en_last_name"],
        armLastName: json["arm_last_name"],
        email: json["email"] == null ? null : json["email"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        dateOfBirth:
            json["date_of_birth"] == null ? null : json["date_of_birth"],
        gender: json["gender"] == null ? null : json["gender"],
        profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
        enDescription:
            json["en_description"] == null ? null : json["en_description"],
        armDescription: json["arm_description"],
        homePhone: json["home_phone"] == null ? null : json["home_phone"],
        cellPhone: json["cell_phone"] == null ? null : json["cell_phone"],
        facebookUrl: json["facebook_url"] == null ? null : json["facebook_url"],
        instagramUrl:
            json["instagram_url"] == null ? null : json["instagram_url"],
        twitterUrl: json["twitter_url"] == null ? null : json["twitter_url"],
        enEducation: json["en_education"] == null ? null : json["en_education"],
        armEducation: json["arm_education"],
        educationId: json["education_id"] == null ? null : json["education_id"],
        occupationId:
            json["occupation_id"] == null ? null : json["occupation_id"],
        enWorkExperience: json["en_work_experience"] == null
            ? null
            : json["en_work_experience"],
        armWorkExperience: json["arm_work_experience"],
        workExperienceId: json["work_experience_id"] == null
            ? null
            : json["work_experience_id"],
        language: json["language"] == null ? null : json["language"],
        pricePerHour:
            json["price_per_hour"] == null ? null : json["price_per_hour"],
        pricePerDay:
            json["price_per_day"] == null ? null : json["price_per_day"],
        pricePerMonth:
            json["price_per_month"] == null ? null : json["price_per_month"],
        smoker: json["smoker"] == null ? null : json["smoker"],
        haveKids: json["have_kids"] == null ? null : json["have_kids"],
        haveDrivingLicense: json["have_driving_license"] == null
            ? null
            : json["have_driving_license"],
        haveCar: json["have_car"] == null ? null : json["have_car"],
        drinker: json["drinker"] == null ? null : json["drinker"],
        serviceProvider:
            json["service_provider"] == null ? null : json["service_provider"],
        verifyStatus:
            json["verify_status"] == null ? null : json["verify_status"],
        status: json["status"] == null ? null : json["status"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "en_first_name": enFirstName == null ? null : enFirstName,
        "arm_first_name": armFirstName,
        "en_last_name": enLastName == null ? null : enLastName,
        "arm_last_name": armLastName,
        "email": email == null ? null : email,
        "category_id": categoryId == null ? null : categoryId,
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
        "gender": gender == null ? null : gender,
        "profile_pic": profilePic == null ? null : profilePic,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "postal_code": postalCode == null ? null : postalCode,
        "en_description": enDescription == null ? null : enDescription,
        "arm_description": armDescription,
        "home_phone": homePhone == null ? null : homePhone,
        "cell_phone": cellPhone == null ? null : cellPhone,
        "facebook_url": facebookUrl == null ? null : facebookUrl,
        "instagram_url": instagramUrl == null ? null : instagramUrl,
        "twitter_url": twitterUrl == null ? null : twitterUrl,
        "en_education": enEducation == null ? null : enEducation,
        "arm_education": armEducation,
        "education_id": educationId == null ? null : educationId,
        "occupation_id": occupationId == null ? null : occupationId,
        "en_work_experience":
            enWorkExperience == null ? null : enWorkExperience,
        "arm_work_experience": armWorkExperience,
        "work_experience_id":
            workExperienceId == null ? null : workExperienceId,
        "language": language == null ? null : language,
        "price_per_hour": pricePerHour == null ? null : pricePerHour,
        "price_per_day": pricePerDay == null ? null : pricePerDay,
        "price_per_month": pricePerMonth == null ? null : pricePerMonth,
        "smoker": smoker == null ? null : smoker,
        "have_kids": haveKids == null ? null : haveKids,
        "have_driving_license":
            haveDrivingLicense == null ? null : haveDrivingLicense,
        "have_car": haveCar == null ? null : haveCar,
        "drinker": drinker == null ? null : drinker,
        "service_provider": serviceProvider == null ? null : serviceProvider,
        "verify_status": verifyStatus == null ? null : verifyStatus,
        "status": status == null ? null : status,
        "api_token": apiToken == null ? null : apiToken,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt,
      };
}
