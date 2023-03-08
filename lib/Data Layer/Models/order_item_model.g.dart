// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as int?,
      quantity: json['quantity'] as int,
      shirt: Shirt.fromJson(json['ordered_shirt'] as Map<String, dynamic>),
      color: ShirtColor.fromJson(json['color'] as Map<String, dynamic>),
      size: ShirtSize.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'ordered_shirt': instance.shirt.toJson(),
      'quantity': instance.quantity,
      'size': instance.size.toJson(),
      'color': instance.color.toJson(),
      'id': instance.id,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      items: (json['items'] as List<dynamic>)
          .map((e) => DatabaseOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

DatabaseOrderItem _$DatabaseOrderItemFromJson(Map<String, dynamic> json) =>
    DatabaseOrderItem(
      color: json['color'] as String,
      shirtId: json['shirtId'] as int,
      id: json['id'] as int,
      price: json['price'] as String,
      quantity: json['quantity'] as int,
      shirt: json['shirt'] as String,
      size: json['size'] as String,
    );

Map<String, dynamic> _$DatabaseOrderItemToJson(DatabaseOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shirtId': instance.shirtId,
      'shirt': instance.shirt,
      'color': instance.color,
      'size': instance.size,
      'price': instance.price,
      'quantity': instance.quantity,
    };
