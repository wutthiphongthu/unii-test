import 'package:json_annotation/json_annotation.dart';
import 'package:unii_test/features/coins/data/models/coin_model.dart';

part 'get_coins_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetCoinsResponseModel {
  const GetCoinsResponseModel({
    required this.status,
    required this.data,
    required this.pagination,
  });

  @JsonKey(defaultValue: '')
  final String status;
  final GetCoinsDataModel data;
  final GetCoinsPaginationModel pagination;

  factory GetCoinsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoinsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoinsResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetCoinsDataModel {
  const GetCoinsDataModel({
    required this.stats,
    required this.coins,
  });

  final GetCoinsStatsModel stats;
  @JsonKey(defaultValue: <CoinModel>[])
  final List<CoinModel> coins;

  factory GetCoinsDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoinsDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoinsDataModelToJson(this);
}

@JsonSerializable()
class GetCoinsStatsModel {
  const GetCoinsStatsModel({
    required this.total,
    required this.totalCoins,
    required this.totalMarkets,
    required this.totalExchanges,
    required this.totalMarketCap,
    required this.total24hVolume,
  });

  @JsonKey(defaultValue: 0)
  final int total;
  @JsonKey(defaultValue: 0)
  final int totalCoins;
  @JsonKey(defaultValue: 0)
  final int totalMarkets;
  @JsonKey(defaultValue: 0)
  final int totalExchanges;
  @JsonKey(
    defaultValue: '',
    fromJson: _stringFromJson,
    toJson: _stringToJson,
  )
  final String totalMarketCap;
  @JsonKey(
    name: 'total24hVolume',
    defaultValue: '',
    fromJson: _stringFromJson,
    toJson: _stringToJson,
  )
  final String total24hVolume;

  factory GetCoinsStatsModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoinsStatsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoinsStatsModelToJson(this);

  static String _stringFromJson(Object? value) => value?.toString() ?? '';
  static String _stringToJson(String value) => value;
}

@JsonSerializable()
class GetCoinsPaginationModel {
  const GetCoinsPaginationModel({
    required this.limit,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.nextCursor,
    required this.previousCursor,
  });

  @JsonKey(defaultValue: 0)
  final int limit;
  @JsonKey(defaultValue: false)
  final bool hasNextPage;
  @JsonKey(defaultValue: false)
  final bool hasPreviousPage;
  final String? nextCursor;
  final String? previousCursor;

  factory GetCoinsPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoinsPaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoinsPaginationModelToJson(this);
}
