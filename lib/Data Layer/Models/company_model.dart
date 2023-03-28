import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_atrocity_matching_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_coupon_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_donation_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_location_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_nonprofit_matching_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/country_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/link_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

part 'company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ForProfitCompany {
  int id;
  String name;
  String? logo;

  @JsonKey(name: 'year_started', disallowNullValue: false)
  String yearStarted;
  String? mission;
  @JsonKey(name: 'website_address')
  String websiteAddress;
  String slug;
  List<Category>? categories;
  List<CompanyNonProfit>? nonprofits;
  List<CompanyAtrocity>? atrocities;
  Profile? owner;
  List<Profile>? contributors;
  String? description;
  String? headquarters;
  List<CompanyStore>? locations;
  String? image;
  List<Link>? links;
  double? totalDonated;
  List<CompanyCoupon>? coupons;
  @JsonKey(name: 'atrocityRelationships')
  List<CompanyAtrocityMatchRelationShip>? atrocityMatchRelationships;
  @JsonKey(name: 'nonprofitRelationships')
  List<CompanyNonProfitMatchRelationship>? nonprofitMatchRelationships;
  int? totalDonationCount;
  AllCompanyDonations? donationsMade;
  ForProfitCompany(
      this.image,
      this.totalDonationCount,
      this.links,
      this.id,
      this.logo,
      this.donationsMade,
      this.mission,
      this.yearStarted,
      this.name,
      this.description,
      this.headquarters,
      this.owner,
      this.totalDonated,
      this.slug,
      this.websiteAddress,
      this.coupons,
      [this.atrocities,
      this.atrocityMatchRelationships,
      this.nonprofitMatchRelationships,
      this.categories,
      this.locations,
      this.nonprofits,
      this.contributors]);

  factory ForProfitCompany.fromJson(Map<String, dynamic> data) =>
      _$ForProfitCompanyFromJson(data);

  Map<String, dynamic> toJson() => _$ForProfitCompanyToJson(this);
}

@JsonSerializable()
class CompanyAtrocity {
  final int id;
  final String title;
  final List<Category> category;
  final Country country;

  CompanyAtrocity({
    required this.id,
    required this.title,
    required this.category,
    required this.country,
  });

  factory CompanyAtrocity.fromJson(Map<String, dynamic> data) =>
      _$CompanyAtrocityFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyAtrocityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyNonProfit {
  final int id;
  final String name;
  final String logo;

  CompanyNonProfit({required this.id, required this.logo, required this.name});

  factory CompanyNonProfit.fromJson(Map<String, dynamic> data) =>
      _$CompanyNonProfitFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyNonProfitToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyCompletion {
  @JsonKey(name: 'name')
  final String companyName;
  @JsonKey(name: 'owner')
  final Profile profile;
  @JsonKey(name: 'mission')
  final String? missionStatement;
  @JsonKey(name: 'address')
  final String companyAddress;
  final String description;
  final String? facebook;
  final String? logo;
  final String? instagram;
  @JsonKey(name: 'website_address')
  final String? wehsite;
  @JsonKey(name: 'year_started')
  final String yearStarted;
  final List<Category>? categories;


  CompanyCompletion(
      {required this.companyAddress,
      required this.companyName,
      required this.description,
      this.facebook,
      this.instagram,
      this.missionStatement,
      required this.profile,
      this.wehsite,
      required this.yearStarted, required int userId, this.logo, this.categories, required String mainImage});

  factory CompanyCompletion.fromJson(Map<String, dynamic> data) =>
      _$CompanyCompletionFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyCompletionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyRep {
  String logo;
  int id;
  String name;

  CompanyRep({required this.id, required this.logo, required this.name});

  factory CompanyRep.fromJson(Map<String, dynamic> data) =>
      _$CompanyRepFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyRepToJson(this);
}
