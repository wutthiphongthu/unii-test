// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_coins_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCoinsResponseModel _$GetCoinsResponseModelFromJson(
  Map<String, dynamic> json,
) => GetCoinsResponseModel(
  status: json['status'] as String? ?? '',
  data: GetCoinsDataModel.fromJson(json['data'] as Map<String, dynamic>),
  pagination: GetCoinsPaginationModel.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GetCoinsResponseModelToJson(
  GetCoinsResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data.toJson(),
  'pagination': instance.pagination.toJson(),
};

GetCoinsDataModel _$GetCoinsDataModelFromJson(Map<String, dynamic> json) =>
    GetCoinsDataModel(
      stats: GetCoinsStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      coins:
          (json['coins'] as List<dynamic>?)
              ?.map((e) => CoinModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetCoinsDataModelToJson(GetCoinsDataModel instance) =>
    <String, dynamic>{
      'stats': instance.stats.toJson(),
      'coins': instance.coins.map((e) => e.toJson()).toList(),
    };

GetCoinsStatsModel _$GetCoinsStatsModelFromJson(Map<String, dynamic> json) =>
    GetCoinsStatsModel(
      total: (json['total'] as num?)?.toInt() ?? 0,
      totalCoins: (json['totalCoins'] as num?)?.toInt() ?? 0,
      totalMarkets: (json['totalMarkets'] as num?)?.toInt() ?? 0,
      totalExchanges: (json['totalExchanges'] as num?)?.toInt() ?? 0,
      totalMarketCap: json['totalMarketCap'] == null
          ? ''
          : GetCoinsStatsModel._stringFromJson(json['totalMarketCap']),
      total24hVolume: json['total24hVolume'] == null
          ? ''
          : GetCoinsStatsModel._stringFromJson(json['total24hVolume']),
    );

Map<String, dynamic> _$GetCoinsStatsModelToJson(
  GetCoinsStatsModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'totalCoins': instance.totalCoins,
  'totalMarkets': instance.totalMarkets,
  'totalExchanges': instance.totalExchanges,
  'totalMarketCap': GetCoinsStatsModel._stringToJson(instance.totalMarketCap),
  'total24hVolume': GetCoinsStatsModel._stringToJson(instance.total24hVolume),
};

GetCoinsPaginationModel _$GetCoinsPaginationModelFromJson(
  Map<String, dynamic> json,
) => GetCoinsPaginationModel(
  limit: (json['limit'] as num?)?.toInt() ?? 0,
  hasNextPage: json['hasNextPage'] as bool? ?? false,
  hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
  nextCursor: json['nextCursor'] as String?,
  previousCursor: json['previousCursor'] as String?,
);

Map<String, dynamic> _$GetCoinsPaginationModelToJson(
  GetCoinsPaginationModel instance,
) => <String, dynamic>{
  'limit': instance.limit,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
  'nextCursor': instance.nextCursor,
  'previousCursor': instance.previousCursor,
};
