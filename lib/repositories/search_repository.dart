import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/search_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';

class SearchRepository {
  Future<GlobalResponse> getSearch({@required SearchParam params}) async {
    try {
      String path = '/search?';
      if (params.query != null) path += '&q=${params.query}';
      if (params.category != null) path += '&category=${params.category}';
      if (params.sortBy != null) path += '&sortby=${params.sortBy}';
      if (params.status != null) path += '&status=${params.status}';
      if (params.priceMin != null) path += '&pricemin=${params.priceMin.toString()}';
      if (params.priceMax != null) path += '&pricemax=${params.priceMax.toString()}';
      if (params.userId != null) path += '&userid=${params.userId}';
      if (params.start != null) path += '&start=${params.start}';
      if (params.limit != null) path += '&limit=${params.limit - 1}';
      path = path.replaceFirst('&', '');
      print(path);
      final response = await ApiClient().httpGetHelper(path, 'getSearch');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> getSearchDeprecated({
    String query,
    String category,
    SortBy sortBy,
    Status status,
    int priceMin,
    int priceMax,
    String userId,
  }) async {
    try {
      String path = '/search?';
      if (query != null) path += '&q=$query';
      if (category != null) path += '&category=$category';
      if (sortBy != null) path += '&sortby=${mapSortByToString(sortBy)}';
      if (status != null) path += '&status=${mapStatusToString(status)}';
      if (priceMin != null) path += '&pricemin=${priceMin.toString()}';
      if (priceMax != null) path += '&pricemax=${priceMax.toString()}';
      if (userId != null) path += '&userid=$userId';
      path = path.replaceFirst('&', '');
      final response = await ApiClient().httpGetHelper(path, 'getSearch');
      final json = jsonDecode(response.body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }
}

enum Category {
  electronics,
  whiteAppliances,
  furnitures,
  kitchens,
  books,
  apparels,
  sports,
  vehicles,
  footwear,
  miscellaneous,
}

String mapCategoryToString(Category value) {
  switch (value) {
    case Category.electronics:
      return 'Electronics';
    case Category.whiteAppliances:
      return 'White+Appliances';
    case Category.furnitures:
      return 'Furnitures';
    case Category.kitchens:
      return 'Kitchens';
    case Category.books:
      return 'Books';
    case Category.apparels:
      return 'Apparels';
    case Category.sports:
      return 'Sports';
    case Category.vehicles:
      return 'Vehicles';
    case Category.footwear:
      return 'Footwear';
    case Category.miscellaneous:
      return 'Miscellaneous';
    default:
      throw Exception('Invalid category value');
  }
}

enum SortBy { relevance, newest, oldest, highestprice, lowestprice }

String mapSortByToString(SortBy value) {
  switch (value) {
    case SortBy.relevance:
      return 'relevance';
    case SortBy.newest:
      return 'newest';
    case SortBy.oldest:
      return 'oldest';
    case SortBy.highestprice:
      return 'highestprice';
    case SortBy.lowestprice:
      return 'lowestprice';
    default:
      throw Exception('Invalid sort by value');
  }
}

enum Status { available, sold }

String mapStatusToString(Status value) {
  switch (value) {
    case Status.available:
      return 'available';
    case Status.sold:
      return 'sold';
    default:
      throw Exception('Invalid status value');
  }
}
