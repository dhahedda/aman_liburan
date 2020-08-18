// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) {
  return DataResponse(
    banners: (json['banners'] as List)
        ?.map((e) => e == null
            ? null
            : BannersResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    categories: (json['categories'] as List)
        ?.map((e) => e == null
            ? null
            : CategoriesResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    featureditems: (json['featureditems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    recentitems: (json['recentitems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    recommendeditems: (json['recommendeditems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    freeitems: (json['freeitems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalItems: json['total_items'] as int,
    items: (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    item: json['item'] == null
        ? null
        : ItemResponse.fromJson(json['item'] as Map<String, dynamic>),
    details: json['details'] == null
        ? null
        : DetailItemResponse.fromJson(json['details'] as Map<String, dynamic>),
    relateditems: (json['relateditems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    selleritems: (json['selleritems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    postedItems: (json['posted_items'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    collections: (json['collections'] as List)
        ?.map((e) => e == null
            ? null
            : ItemsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    appointments: (json['appointments'] as List)
        ?.map((e) => e == null
            ? null
            : AppointmentResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    notifications: (json['notifications'] as List)
        ?.map((e) => e == null
            ? null
            : NotificationResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    profile: json['profile'] == null
        ? null
        : ProfileResponse.fromJson(json['profile'] as Map<String, dynamic>),
    paymentMethod: json['payment_method'] == null
        ? null
        : PaymentMethodResponse.fromJson(
            json['payment_method'] as Map<String, dynamic>),
    userInfo: json['user_info'] == null
        ? null
        : UserInfoResponse.fromJson(json['user_info'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] == null
        ? null
        : TokenResponse.fromJson(json['token'] as Map<String, dynamic>),
    totalMessages: json['total_messages'] as int,
    chatLobby: (json['chat_lobby'] as List)
        ?.map((e) => e == null
            ? null
            : ChatLobbyResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    messages: (json['messages'] as List)
        ?.map((e) => e == null
            ? null
            : RoomMessageResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    room: json['room'] == null
        ? null
        : ChatLobbyResponse.fromJson(json['room'] as Map<String, dynamic>),
  )..seller = json['seller'] == null
      ? null
      : SellerResponse.fromJson(json['seller'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'banners': instance.banners,
      'categories': instance.categories,
      'featureditems': instance.featureditems,
      'recentitems': instance.recentitems,
      'recommendeditems': instance.recommendeditems,
      'freeitems': instance.freeitems,
      'total_items': instance.totalItems,
      'items': instance.items,
      'item': instance.item,
      'details': instance.details,
      'seller': instance.seller,
      'relateditems': instance.relateditems,
      'selleritems': instance.selleritems,
      'posted_items': instance.postedItems,
      'collections': instance.collections,
      'appointments': instance.appointments,
      'notifications': instance.notifications,
      'profile': instance.profile,
      'payment_method': instance.paymentMethod,
      'user_info': instance.userInfo,
      'user': instance.user,
      'token': instance.token,
      'total_messages': instance.totalMessages,
      'chat_lobby': instance.chatLobby,
      'messages': instance.messages,
      'room': instance.room,
    };
