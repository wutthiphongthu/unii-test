// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinDetailModel _$CoinDetailModelFromJson(Map<String, dynamic> json) =>
    CoinDetailModel(
      id: json['uuid'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      color: json['color'] as String? ?? '',
      imageUrl: json['iconUrl'] as String? ?? '',
      websiteUrl: json['websiteUrl'] as String? ?? '',
      links:
          (json['links'] as List<dynamic>?)
              ?.map((e) => CoinLinkModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      supply: CoinDetailModel._supplyFromJson(json['supply']),
      numberOfMarkets: (json['numberOfMarkets'] as num?)?.toInt() ?? 0,
      numberOfExchanges: (json['numberOfExchanges'] as num?)?.toInt() ?? 0,
      currentPrice: CoinDetailModel._doubleFromJson(json['price']),
      marketCap: CoinDetailModel._doubleFromJson(json['marketCap']),
      fullyDilutedMarketCap: CoinDetailModel._doubleFromJson(
        json['fullyDilutedMarketCap'],
      ),
      priceAt: CoinDetailModel._intFromJson(json['priceAt']),
      change: CoinDetailModel._doubleFromJson(json['change']),
      sparkline: CoinDetailModel._doubleListFromJson(json['sparkline']),
      allTimeHigh: CoinDetailModel._allTimeHighFromJson(json['allTimeHigh']),
      coinrankingUrl: json['coinrankingUrl'] as String? ?? '',
      tier: CoinDetailModel._intFromJson(json['tier']),
      lowVolume: json['lowVolume'] as bool? ?? false,
      listedAt: CoinDetailModel._intFromJson(json['listedAt']),
      hasContent: json['hasContent'] as bool? ?? false,
      notices: json['notices'] as String?,
      contractAddresses:
          (json['contractAddresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      isWrappedTrustless: json['isWrappedTrustless'] as bool? ?? false,
      wrappedTo: json['wrappedTo'] as String?,
      marketCapRank: CoinDetailModel._intFromJson(json['rank']),
      high24h: CoinDetailModel._doubleFromJson(json['24hVolume']),
      low24h: CoinDetailModel._doubleFromJson(json['btcPrice']),
    );

Map<String, dynamic> _$CoinDetailModelToJson(CoinDetailModel instance) =>
    <String, dynamic>{
      'uuid': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
      'iconUrl': instance.imageUrl,
      'websiteUrl': instance.websiteUrl,
      'links': instance.links.map((e) => e.toJson()).toList(),
      'supply': CoinDetailModel._supplyToJson(instance.supply),
      'numberOfMarkets': instance.numberOfMarkets,
      'numberOfExchanges': instance.numberOfExchanges,
      'price': CoinDetailModel._doubleToJson(instance.currentPrice),
      'marketCap': CoinDetailModel._doubleToJson(instance.marketCap),
      'fullyDilutedMarketCap': CoinDetailModel._doubleToJson(
        instance.fullyDilutedMarketCap,
      ),
      'priceAt': CoinDetailModel._intToJson(instance.priceAt),
      'change': CoinDetailModel._doubleToJson(instance.change),
      'sparkline': CoinDetailModel._doubleListToJson(instance.sparkline),
      'allTimeHigh': CoinDetailModel._allTimeHighToJson(instance.allTimeHigh),
      'coinrankingUrl': instance.coinrankingUrl,
      'tier': CoinDetailModel._intToJson(instance.tier),
      'lowVolume': instance.lowVolume,
      'listedAt': CoinDetailModel._intToJson(instance.listedAt),
      'hasContent': instance.hasContent,
      'notices': instance.notices,
      'contractAddresses': instance.contractAddresses,
      'tags': instance.tags,
      'isWrappedTrustless': instance.isWrappedTrustless,
      'wrappedTo': instance.wrappedTo,
      'rank': CoinDetailModel._intToJson(instance.marketCapRank),
      '24hVolume': CoinDetailModel._doubleToJson(instance.high24h),
      'btcPrice': CoinDetailModel._doubleToJson(instance.low24h),
    };

CoinLinkModel _$CoinLinkModelFromJson(Map<String, dynamic> json) =>
    CoinLinkModel(
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$CoinLinkModelToJson(CoinLinkModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'url': instance.url,
    };

CoinSupplyModel _$CoinSupplyModelFromJson(Map<String, dynamic> json) =>
    CoinSupplyModel(
      confirmed: json['confirmed'] as bool? ?? false,
      supplyAt: CoinDetailModel._intFromJson(json['supplyAt']),
      max: CoinSupplyModel._stringOrNullFromJson(json['max']),
      total: json['total'] as String? ?? '',
      circulating: json['circulating'] as String? ?? '',
    );

Map<String, dynamic> _$CoinSupplyModelToJson(CoinSupplyModel instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'supplyAt': CoinDetailModel._intToJson(instance.supplyAt),
      'max': CoinSupplyModel._stringOrNullToJson(instance.max),
      'total': instance.total,
      'circulating': instance.circulating,
    };

CoinAllTimeHighModel _$CoinAllTimeHighModelFromJson(
  Map<String, dynamic> json,
) => CoinAllTimeHighModel(
  price: CoinDetailModel._doubleFromJson(json['price']),
  timestamp: CoinDetailModel._intFromJson(json['timestamp']),
);

Map<String, dynamic> _$CoinAllTimeHighModelToJson(
  CoinAllTimeHighModel instance,
) => <String, dynamic>{
  'price': CoinDetailModel._doubleToJson(instance.price),
  'timestamp': CoinDetailModel._intToJson(instance.timestamp),
};
