import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  const CoinEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.currentPrice,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
  });

  final String id;
  final String symbol;
  final String name;
  final String imageUrl;
  final double currentPrice;
  final int marketCapRank;
  final double priceChangePercentage24h;

  CoinEntity copyWith({
    String? id,
    String? symbol,
    String? name,
    String? imageUrl,
    double? currentPrice,
    int? marketCapRank,
    double? priceChangePercentage24h,
  }) {
    return CoinEntity(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      priceChangePercentage24h:
          priceChangePercentage24h ?? this.priceChangePercentage24h,
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        imageUrl,
        currentPrice,
        marketCapRank,
        priceChangePercentage24h,
      ];
}
