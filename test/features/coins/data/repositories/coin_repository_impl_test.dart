import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unii_test/features/coins/data/datasources/coin_remote_data_source.dart';
import 'package:unii_test/features/coins/data/models/coin_detail_model.dart';
import 'package:unii_test/features/coins/data/models/coin_model.dart';
import 'package:unii_test/features/coins/data/repositories/coin_repository_impl.dart';

class _MockCoinRemoteDataSource extends Mock implements CoinRemoteDataSource {}

void main() {
  late CoinRemoteDataSource remoteDataSource;
  late CoinRepositoryImpl repository;

  setUp(() {
    remoteDataSource = _MockCoinRemoteDataSource();
    repository = CoinRepositoryImpl(remoteDataSource);
  });

  test('getCoins maps models to entities', () async {
    const models = <CoinModel>[
      CoinModel(
        id: 'bitcoin',
        symbol: 'btc',
        name: 'Bitcoin',
        imageUrl: 'https://example.com/bitcoin.svg',
        currentPrice: 100000,
        marketCapRank: 1,
        priceChangePercentage24h: 1.5,
      ),
    ];
    when(
      () => remoteDataSource.getCoins(page: 1, perPage: 20, query: ''),
    ).thenAnswer((_) async => models);

    final result = await repository.getCoins(page: 1, perPage: 20);

    expect(result, hasLength(1));
    expect(result.first.id, 'bitcoin');
    expect(result.first.imageUrl, 'https://example.com/bitcoin.png');
    verify(() => remoteDataSource.getCoins(page: 1, perPage: 20, query: ''))
        .called(1);
  });

  test('getCoinDetail maps model to entity', () async {
    final model = CoinDetailModel.fromJson(<String, dynamic>{
      'uuid': 'bitcoin',
      'symbol': 'btc',
      'name': 'Bitcoin',
      'description': 'detail',
      'iconUrl': 'https://example.com/bitcoin.svg',
      'websiteUrl': 'https://bitcoin.org',
      'price': '100000',
      'marketCap': '2000000000',
      'rank': '1',
      '24hVolume': '5000000',
      'btcPrice': '1',
      'color': '#f7931A',
    });
    when(
      () => remoteDataSource.getCoinDetail(coinId: 'bitcoin'),
    ).thenAnswer((_) async => model);

    final result = await repository.getCoinDetail(coinId: 'bitcoin');

    expect(result.id, 'bitcoin');
    expect(result.imageUrl, 'https://example.com/bitcoin.png');
    expect(result.marketCapRank, 1);
    verify(() => remoteDataSource.getCoinDetail(coinId: 'bitcoin')).called(1);
  });

  test('getCoins throws readable error when DioException occurs', () async {
    when(
      () => remoteDataSource.getCoins(page: 1, perPage: 20, query: ''),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v2/coins'),
        message: 'Network unavailable',
      ),
    );

    expect(
      () => repository.getCoins(page: 1, perPage: 20),
      throwsA(
        isA<Exception>().having(
          (error) => error.toString(),
          'message',
          contains('Network unavailable'),
        ),
      ),
    );
  });

  test('getCoinDetail throws readable error when DioException occurs', () async {
    when(
      () => remoteDataSource.getCoinDetail(coinId: 'bitcoin'),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/v2/coin/bitcoin'),
        message: 'Request timed out',
      ),
    );

    expect(
      () => repository.getCoinDetail(coinId: 'bitcoin'),
      throwsA(
        isA<Exception>().having(
          (error) => error.toString(),
          'message',
          contains('Request timed out'),
        ),
      ),
    );
  });
}
