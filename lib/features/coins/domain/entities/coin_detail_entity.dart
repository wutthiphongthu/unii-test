import 'package:equatable/equatable.dart';

class CoinDetailEntity extends Equatable {
  const CoinDetailEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.websiteUrl,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.high24h,
    required this.low24h,
    required this.symbolColor,
  });

  final String id;
  final String symbol;
  final String name;
  final String description;
  final String imageUrl;
  final String websiteUrl;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double high24h;
  final double low24h;
  final String symbolColor;

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    description,
    imageUrl,
    websiteUrl,
    currentPrice,
    marketCap,
    marketCapRank,
    high24h,
    low24h,
    symbolColor,
  ];
}
