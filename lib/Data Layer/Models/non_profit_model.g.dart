// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'non_profit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonProfit _$NonProfitFromJson(Map<String, dynamic> json) => NonProfit(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      description: json['description'] as String?,
      facebook: json['facebook'] as String?,
      yearStarted: json['year_started'] as int?,
      missionStatement: json['mission_statement'] as String?,
      projects: json['projects'] as List<NonProfitProject>?,
      visionStatement: json['vision_statement'] as String?,
      websiteUrl: json['website_url'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      slug: json['slug'] as String?,
      atrocity: (json['atrocity_List'] as List<dynamic>?)
          ?.map((e) => Atrocity.fromJson(e as Map<String, dynamic>))
          .toList(),
      shirtList: (json['shirtList'] as List<dynamic>?)
          ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
          .toList(),
      avgDonation: (json['avgDonation'] as num?)?.toDouble(),
      mainImage: json['main_image'] as String?,
      balance: (json['total_balance'] as num?)?.toDouble(),
      companiesSupporting:
          json['companiesSupporting'] as List<CompaniesSupporting>?,
      contributors: json['contributors'] as List<Profile>?,
      owner: json['owner'],
      matchingPartnerships: json['matchingPartnerships']
          as List<CompanyNonProfitMatchRelationship>?,
      links: json['links'] as List<Link>?,
    )..recentDonors = json['recentDonors'] as List<ProfileRepresentation>?;

Map<String, dynamic> _$NonProfitToJson(NonProfit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'description': instance.description,
      'year_started': instance.yearStarted,
      'mission_statement': instance.missionStatement,
      'vision_statement': instance.visionStatement,
      'website_url': instance.websiteUrl,
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'slug': instance.slug,
      'atrocity_List': instance.atrocity?.map((e) => e.toJson()).toList(),
      'shirtList': instance.shirtList?.map((e) => e.toJson()).toList(),
      'main_image': instance.mainImage,
      'total_balance': instance.balance,
      'companiesSupporting': instance.companiesSupporting,
      'contributors': instance.contributors,
      'owner': instance.owner,
      'links': instance.links,
      'projects': instance.projects,
      'avgDonation': instance.avgDonation,
      'recentDonors': instance.recentDonors,
      'matchingPartnerships': instance.matchingPartnerships,
      'facebook': instance.facebook,
    };

NonProfitCompletion _$NonProfitCompletionFromJson(Map<String, dynamic> json) =>
    NonProfitCompletion(
      website: json['website_url'] as String?,
      instagram: json['instagram'] as String?,
      profile: json['owner'],
      name: json['name'] as String,
      description: json['description'] as String,
      facebook: json['facebook'] as String?,
      missionStatement: json['mission_statement'] as String,
      visionStatement: json['vision_statement'] as String,
      yearStarted: json['year_started'] as int,
    );

Map<String, dynamic> _$NonProfitCompletionToJson(
        NonProfitCompletion instance) =>
    <String, dynamic>{
      'owner': instance.profile,
      'year_started': instance.yearStarted,
      'name': instance.name,
      'mission_statement': instance.missionStatement,
      'vision_statement': instance.visionStatement,
      'facebook': instance.facebook,
      'website_url': instance.website,
      'instagram': instance.instagram,
      'description': instance.description,
    };

NonProfitRep _$NonProfitRepFromJson(Map<String, dynamic> json) => NonProfitRep(
      id: json['id'] as int,
      logo: json['logo'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NonProfitRepToJson(NonProfitRep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
