import 'package:aman_liburan/models/response/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DataResponse {
  List<BannersResponse> banners;
  List<CategoriesResponse> categories;
  List<ItemsResponse> featureditems;
  List<ItemsResponse> recentitems;
  List<ItemsResponse> recommendeditems;
  List<ItemsResponse> freeitems;
  int totalItems;
  List<ItemsResponse> items;

  ItemResponse item;
  DetailItemResponse details;
  SellerResponse seller;
  List<ItemsResponse> relateditems;
  List<ItemsResponse> selleritems;
  List<ItemsResponse> postedItems;
  List<ItemsResponse> collections;
  List<AppointmentResponse> appointments;
  List<NotificationResponse> notifications;
  ProfileResponse profile;
  PaymentMethodResponse paymentMethod;
  UserInfoResponse userInfo;
  UserResponse user;
  TokenResponse token;

  int totalMessages;
  List<ChatLobbyResponse> chatLobby;
  List<RoomMessageResponse> messages;
  ChatLobbyResponse room;

  DataResponse({
    this.banners,
    this.categories,
    this.featureditems,
    this.recentitems,
    this.recommendeditems,
    this.freeitems,
    this.totalItems,
    this.items,
    this.item,
    this.details,
    this.relateditems,
    this.selleritems,
    this.postedItems,
    this.collections,
    this.appointments,
    this.notifications,
    this.profile,
    this.paymentMethod,
    this.userInfo,
    this.user,
    this.token,
    this.totalMessages,
    this.chatLobby,
    this.messages,
    this.room,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}
