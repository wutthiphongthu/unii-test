// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinModel _$CoinModelFromJson(Map<String, dynamic> json) => CoinModel(
  id: json['uuid'] as String? ?? '',
  symbol: json['symbol'] as String? ?? '',
  name: json['name'] as String? ?? '',
  imageUrl: json['iconUrl'] as String? ?? '',
  currentPrice: CoinModel._doubleFromJson(json['price']),
  marketCapRank: CoinModel._intFromJson(json['rank']),
  priceChangePercentage24h: CoinModel._doubleFromJson(json['change']),
);

Map<String, dynamic> _$CoinModelToJson(CoinModel instance) => <String, dynamic>{
  'uuid': instance.id,
  'symbol': instance.symbol,
  'name': instance.name,
  'iconUrl': instance.imageUrl,
  'price': CoinModel._doubleToJson(instance.currentPrice),
  'rank': CoinModel._intToJson(instance.marketCapRank),
  'change': CoinModel._doubleToJson(instance.priceChangePercentage24h),
};
