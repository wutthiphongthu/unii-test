import 'package:flutter_test/flutter_test.dart';
import 'package:unii_test/features/coins/data/models/coin_model.dart';

void main() {
  test('fromJson parses string values and toEntity normalizes svg icon', () {
    final model = CoinModel.fromJson(<String, dynamic>{
      'uuid': 'bitcoin',
      'symbol': 'btc',
      'name': 'Bitcoin',
      'iconUrl': 'https://cdn.example.com/bitcoin.svg',
      'price': '100000.5',
      'rank': '001',
      'change': '-2.5',
    });

    final entity = model.toEntity();

    expect(model.currentPrice, 100000.5);
    expect(model.marketCapRank, 1);
    expect(model.priceChangePercentage24h, -2.5);
    expect(entity.imageUrl, 'https://cdn.example.com/bitcoin.png');
  });

  test('toJson keeps API field names and string-formatted values', () {
    const model = CoinModel(
      id: 'ethereum',
      symbol: 'eth',
      name: 'Ethereum',
      imageUrl: 'https://cdn.example.com/eth.png',
      currentPrice: 2500,
      marketCapRank: 2,
      priceChangePercentage24h: 1.25,
    );

    final json = model.toJson();

    expect(json['uuid'], 'ethereum');
    expect(json['iconUrl'], 'https://cdn.example.com/eth.png');
    expect(json['price'], '2500.0');
    expect(json['rank'], '2');
    expect(json['change'], '1.25');
  });
}
