// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/extensions.dart';
import '../../utils/utils.dart';

abstract class BaseResponse {
  int statusCode;
  ErrorResponse? error;

  bool get success => statusCode == 200 || statusCode == 201;

  BaseResponse({this.statusCode = 0});

  external T fromJson<T extends BaseResponse>(Map<String, dynamic> json);

  toModel() {}
}

class SingleResponse<T extends BaseResponse> extends BaseResponse {
  T? item;

  SingleResponse(this.item, {int? statusCode})
      : super(statusCode: statusCode ?? 0);

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  SingleResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    final map = JsonUtils.getMap(response.data);
    if (success) {
      final result = GetIt.I.get<T>();

      item = result.fromJson<T>(map);
    } else {
      this.error = ErrorResponse.fromJson(map);
    }
  }

  SingleResponse.fromString(String data) {
    statusCode = 200;

    final map = JsonUtils.getMap(data);
    final result = GetIt.I.get<T>();

    item = result.fromJson<T>(map);
  }
}

class ListResponse<T extends BaseResponse, Y> extends BaseResponse {
  List<T> items = [];

  ListResponse(this.items) : super();

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  ListResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    if (success) {
      final list = JsonUtils.getMapList(response.data);
      final result = GetIt.I.get<T>();

      items = list.map((map) => result.fromJson<T>(map)).toList();
    } else {
      this.error = ErrorResponse.fromJson(JsonUtils.getMap(response.data));
      items = [];
    }
  }

  List<Y> toListModel() {
    final List<Y> listModel = items.map((e) => e.toModel() as Y).toList();
    return listModel;
  }

  ListResponse.fromString(String data) {
    statusCode = 200;
    final list = JsonUtils.getMapList(data);
    final result = GetIt.I.get<T>();
    items = list.map((map) => result.fromJson<T>(map)).toList();
  }
}

class PagingListResponse<T extends BaseResponse> extends BaseResponse {
  List<T> items = [];
  Pagination? pagination;
  String? nextPageToken;
  Map<String, dynamic>? extra;

  PagingListResponse(this.items) : super();

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  PagingListResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    final map = JsonUtils.getMap(response.data);
    if (success) {
      final list = JsonUtils.getMapList(map['results']);
      final result = GetIt.I.get<T>();

      pagination = Pagination.fromJson(map['pagination'] ?? {});
      nextPageToken = map['next_page_token'];
      items = list.map((map) => result.fromJson<T>(map)).toList();

      if (map.containsKey('duration')) {
        final int duration = map['duration'];
        extra = {'duration': duration};
      }
    } else {
      this.error = ErrorResponse.fromJson(map);
      items = [];
    }
  }

  PagingListResponse.fromString(String data) {
    statusCode = 200;
    final map = JsonUtils.getMap(data);
    final list = JsonUtils.getMapList(map['results']);
    final result = GetIt.I.get<T>();

    pagination = Pagination.fromJson(map['pagination'] ?? {});
    pagination = pagination?.copyWith(canLoadMoreManual: false);
    items = list.map((map) => result.fromJson<T>(map)).toList();
  }
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;
  bool? canLoadMoreManual;

  bool get canLoadMore => canLoadMoreManual ?? page < pageCount;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
    this.canLoadMoreManual,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: int.tryParse(json['page'].toString()) ?? 0,
        pageSize: int.tryParse(json['pageSize'].toString()) ?? 0,
        pageCount: int.tryParse(json['pageCount'].toString()) ?? 0,
        total: int.tryParse(json['total'].toString()) ?? 0,
      );

  Pagination copyWith({
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
    bool? canLoadMoreManual,
  }) {
    return Pagination(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      pageCount: pageCount ?? this.pageCount,
      total: total ?? this.total,
      canLoadMoreManual: canLoadMoreManual ?? this.canLoadMoreManual,
    );
  }
}

class ErrorResponse {
  String error;
  String errorMessage;
  String data;
  List<ErrorMessageResponse> errorMessageList;

  ErrorResponse({
    required this.error,
    required this.errorMessageList,
    required this.errorMessage,
    required this.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    var errorList = <ErrorMessageResponse>[];
    var errorMessage = '';
    var data = '';

    if (json["error_descrip"] is List) {
      final message =
          List<dynamic>.from((json["error_descrip"] ?? []).map((x) => x));
      final firstMessage = message.firstOrDefault();
      if (firstMessage != null) {
        errorList = List<ErrorMessageResponse>.from(
          (firstMessage["error_descrip"] ?? []).map(
            (x) => ErrorMessageResponse.fromJson(x),
          ),
        );
      }
    } else if (json["error_descrip"] is String) {
      errorMessage = json["error_descrip"];
    }
    return ErrorResponse(
      error: json['error'] ?? '',
      errorMessageList: errorList,
      errorMessage: errorMessage,
      data: data,
    );
  }
}

class ErrorMessageResponse {
  String id;
  String message;

  ErrorMessageResponse({required this.id, required this.message});

  factory ErrorMessageResponse.fromJson(Map<String, dynamic> json) =>
      ErrorMessageResponse(
        id: json['errorMessage'] ?? '',
        message: json['errorCode'] ?? '',
      );
}

class CreatorListResponse<T extends BaseResponse> extends BaseResponse {
  List<T> items = [];

  CreatorListResponse(this.items) : super();

  @override
  bool get success => statusCode == 200 || statusCode == 201;

  CreatorListResponse.fromJson(Response response) {
    this.statusCode = response.statusCode ?? 0;

    if (success) {
      final list =
          JsonUtils.getMapList(JsonUtils.getMap(response.data)['creators']);
      final result = GetIt.I.get<T>();

      items = list.map((map) => result.fromJson<T>(map)).toList();
    } else {
      this.error = ErrorResponse.fromJson(JsonUtils.getMap(response.data));
      items = [];
    }
  }
}
