import 'package:json_annotation/json_annotation.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';

part 'coin_model.g.dart';

@JsonSerializable()
class CoinModel {
  const CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.currentPrice,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
  });

  @JsonKey(name: 'uuid', defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String symbol;
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(name: 'iconUrl', defaultValue: '')
  final String imageUrl;
  @JsonKey(
    name: 'price',
    fromJson: _doubleFromJson,
    toJson: _doubleToJson,
  )
  final double currentPrice;
  @JsonKey(
    name: 'rank',
    fromJson: _intFromJson,
    toJson: _intToJson,
  )
  final int marketCapRank;
  @JsonKey(
    name: 'change',
    fromJson: _doubleFromJson,
    toJson: _doubleToJson,
  )
  final double priceChangePercentage24h;

  factory CoinModel.fromJson(Map<String, dynamic> json) =>
      _$CoinModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoinModelToJson(this);

  CoinEntity toEntity() {
    return CoinEntity(
      id: id,
      symbol: symbol,
      name: name,
      imageUrl: _normalizeIconUrl(imageUrl),
      currentPrice: currentPrice,
      marketCapRank: marketCapRank,
      priceChangePercentage24h: priceChangePercentage24h,
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
}
