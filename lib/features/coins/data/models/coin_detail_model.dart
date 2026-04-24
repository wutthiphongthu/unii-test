import 'package:json_annotation/json_annotation.dart';
import 'package:unii_test/features/coins/domain/entities/coin_detail_entity.dart';

part 'coin_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CoinDetailModel {
  const CoinDetailModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.description,
    required this.color,
    required this.imageUrl,
    required this.websiteUrl,
    required this.links,
    required this.supply,
    required this.numberOfMarkets,
    required this.numberOfExchanges,
    required this.currentPrice,
    required this.marketCap,
    required this.fullyDilutedMarketCap,
    required this.priceAt,
    required this.change,
    required this.sparkline,
    required this.allTimeHigh,
    required this.coinrankingUrl,
    required this.tier,
    required this.lowVolume,
    required this.listedAt,
    required this.hasContent,
    required this.notices,
    required this.contractAddresses,
    required this.tags,
    required this.isWrappedTrustless,
    required this.wrappedTo,
    required this.marketCapRank,
    required this.high24h,
    required this.low24h,
  });

  @JsonKey(name: 'uuid', defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String symbol;
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: '')
  final String color;
  @JsonKey(name: 'iconUrl', defaultValue: '')
  final String imageUrl;
  @JsonKey(defaultValue: '')
  final String websiteUrl;
  @JsonKey(defaultValue: <CoinLinkModel>[])
  final List<CoinLinkModel> links;
  @JsonKey(fromJson: _supplyFromJson, toJson: _supplyToJson)
  final CoinSupplyModel supply;
  @JsonKey(defaultValue: 0)
  final int numberOfMarkets;
  @JsonKey(defaultValue: 0)
  final int numberOfExchanges;
  @JsonKey(name: 'price', fromJson: _doubleFromJson, toJson: _doubleToJson)
  final double currentPrice;
  @JsonKey(name: 'marketCap', fromJson: _doubleFromJson, toJson: _doubleToJson)
  final double marketCap;
  @JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson)
  final double fullyDilutedMarketCap;
  @JsonKey(fromJson: _intFromJson, toJson: _intToJson)
  final int priceAt;
  @JsonKey(fromJson: _doubleFromJson, toJson: _doubleToJson)
  final double change;
  @JsonKey(fromJson: _doubleListFromJson, toJson: _doubleListToJson)
  final List<double> sparkline;
  @JsonKey(fromJson: _allTimeHighFromJson, toJson: _allTimeHighToJson)
  final CoinAllTimeHighModel allTimeHigh;
  @JsonKey(defaultValue: '')
  final String coinrankingUrl;
  @JsonKey(fromJson: _intFromJson, toJson: _intToJson)
  final int tier;
  @JsonKey(defaultValue: false)
  final bool lowVolume;
  @JsonKey(fromJson: _intFromJson, toJson: _intToJson)
  final int listedAt;
  @JsonKey(defaultValue: false)
  final bool hasContent;
  final String? notices;
  @JsonKey(defaultValue: <String>[])
  final List<String> contractAddresses;
  @JsonKey(defaultValue: <String>[])
  final List<String> tags;
  @JsonKey(defaultValue: false)
  final bool isWrappedTrustless;
  final String? wrappedTo;
  @JsonKey(name: 'rank', fromJson: _intFromJson, toJson: _intToJson)
  final int marketCapRank;

  // Kept for compatibility with existing UI mapping.
  @JsonKey(name: '24hVolume', fromJson: _doubleFromJson, toJson: _doubleToJson)
  final double high24h;
  // Kept for compatibility with existing UI mapping.
  @JsonKey(name: 'btcPrice', fromJson: _doubleFromJson, toJson: _doubleToJson)
  final double low24h;

  factory CoinDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinDetailModelToJson(this);

  CoinDetailEntity toEntity() {
    return CoinDetailEntity(
      id: id,
      symbol: symbol,
      name: name,
      description: description,
      imageUrl: _normalizeIconUrl(imageUrl),
      websiteUrl: websiteUrl,
      currentPrice: currentPrice,
      marketCap: marketCap,
      marketCapRank: marketCapRank,
      high24h: high24h,
      low24h: low24h,
      symbolColor: color,
    );
  }

  static String _normalizeIconUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return url;
    }
    if (!uri.path.toLowerCase().endsWith('.svg')) {
      return url;
    }
    final pngPath = uri.path.replaceFirst(
      RegExp(r'\.svg$', caseSensitive: false),
      '.png',
    );
    return uri.replace(path: pngPath).toString();
  }

  static double _doubleFromJson(Object? value) {
    return double.tryParse((value ?? '0').toString()) ?? 0;
  }

  static String _doubleToJson(double value) => value.toString();

  static int _intFromJson(Object? value) {
    return int.tryParse((value ?? '0').toString()) ?? 0;
  }

  static String _intToJson(int value) => value.toString();

  static List<double> _doubleListFromJson(Object? value) {
    if (value is! List) {
      return const <double>[];
    }
    return value
        .map((e) => double.tryParse(e.toString()) ?? 0)
        .toList(growable: false);
  }

  static List<String> _doubleListToJson(List<double> value) {
    return value.map((e) => e.toString()).toList(growable: false);
  }

  static CoinSupplyModel _supplyFromJson(Object? value) {
    if (value is Map<String, dynamic>) {
      return CoinSupplyModel.fromJson(value);
    }
    return const CoinSupplyModel(
      confirmed: false,
      supplyAt: 0,
      max: null,
      total: '',
      circulating: '',
    );
  }

  static Map<String, dynamic> _supplyToJson(CoinSupplyModel value) {
    return value.toJson();
  }

  static CoinAllTimeHighModel _allTimeHighFromJson(Object? value) {
    if (value is Map<String, dynamic>) {
      return CoinAllTimeHighModel.fromJson(value);
    }
    return const CoinAllTimeHighModel(price: 0, timestamp: 0);
  }

  static Map<String, dynamic> _allTimeHighToJson(CoinAllTimeHighModel value) {
    return value.toJson();
  }
}

@JsonSerializable()
class CoinLinkModel {
  const CoinLinkModel({
    required this.name,
    required this.type,
    required this.url,
  });

  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String type;
  @JsonKey(defaultValue: '')
  final String url;

  factory CoinLinkModel.fromJson(Map<String, dynamic> json) =>
      _$CoinLinkModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinLinkModelToJson(this);
}

@JsonSerializable()
class CoinSupplyModel {
  const CoinSupplyModel({
    required this.confirmed,
    required this.supplyAt,
    required this.max,
    required this.total,
    required this.circulating,
  });

  @JsonKey(defaultValue: false)
  final bool confirmed;
  @JsonKey(
    fromJson: CoinDetailModel._intFromJson,
    toJson: CoinDetailModel._intToJson,
  )
  final int supplyAt;
  @JsonKey(fromJson: _stringOrNullFromJson, toJson: _stringOrNullToJson)
  final String? max;
  @JsonKey(defaultValue: '')
  final String total;
  @JsonKey(defaultValue: '')
  final String circulating;

  factory CoinSupplyModel.fromJson(Map<String, dynamic> json) =>
      _$CoinSupplyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinSupplyModelToJson(this);

  static String? _stringOrNullFromJson(Object? value) => value?.toString();
  static Object? _stringOrNullToJson(String? value) => value;
}

@JsonSerializable()
class CoinAllTimeHighModel {
  const CoinAllTimeHighModel({required this.price, required this.timestamp});

  @JsonKey(
    fromJson: CoinDetailModel._doubleFromJson,
    toJson: CoinDetailModel._doubleToJson,
  )
  final double price;
  @JsonKey(
    fromJson: CoinDetailModel._intFromJson,
    toJson: CoinDetailModel._intToJson,
  )
  final int timestamp;

  factory CoinAllTimeHighModel.fromJson(Map<String, dynamic> json) =>
      _$CoinAllTimeHighModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinAllTimeHighModelToJson(this);
}
