// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_atrocity_matching_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyAtrocityMatchRelationShip _$CompanyAtrocityMatchRelationShipFromJson(
        Map<String, dynamic> json) =>
    CompanyAtrocityMatchRelationShip(
      atrocity:
          CompanyAtrocity.fromJson(json['atrocity'] as Map<String, dynamic>),
      fundingLimit: (json['funding_limit'] as num).toDouble(),
      matchLevel: json['match_level'] as int,
      totalRaised: (json['total_raised'] as num).toDouble(),
    );

Map<String, dynamic> _$CompanyAtrocityMatchRelationShipToJson(
        CompanyAtrocityMatchRelationShip instance) =>
    <String, dynamic>{
      'match_level': instance.matchLevel,
      'total_raised': instance.totalRaised,
      'atrocity': instance.atrocity.toJson(),
      'funding_limit': instance.fundingLimit,
    };
