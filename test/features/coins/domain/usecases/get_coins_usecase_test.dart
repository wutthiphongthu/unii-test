import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unii_test/core/constants/app_constants.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';
import 'package:unii_test/features/coins/domain/repositories/coin_repository.dart';
import 'package:unii_test/features/coins/domain/usecases/get_coins_usecase.dart';

class _MockCoinRepository extends Mock implements CoinRepository {}

void main() {
  late CoinRepository repository;
  late GetCoinsUseCase useCase;

  setUp(() {
    repository = _MockCoinRepository();
    useCase = GetCoinsUseCase(repository);
  });

  test('returns coins from repository', () async {
    const expected = <CoinEntity>[
      CoinEntity(
        id: 'bitcoin',
        symbol: 'btc',
        name: 'Bitcoin',
        imageUrl: 'https://example.com/btc.png',
        currentPrice: 100000,
        marketCapRank: 1,
        priceChangePercentage24h: 1.5,
      ),
    ];
    when(
      () => repository.getCoins(
        page: 1,
        perPage: AppConstants.pageSize,
        query: '',
      ),
    ).thenAnswer((_) async => expected);

    final result = await useCase(page: 1);

    expect(result, expected);
    verify(
      () => repository.getCoins(
        page: 1,
        perPage: AppConstants.pageSize,
        query: '',
      ),
    ).called(1);
  });

  test('forwards custom perPage and query to repository', () async {
    when(
      () => repository.getCoins(
        page: 2,
        perPage: 50,
        query: 'btc',
      ),
    ).thenAnswer((_) async => const <CoinEntity>[]);

    await useCase(page: 2, perPage: 50, query: 'btc');

    verify(
      () => repository.getCoins(
        page: 2,
        perPage: 50,
        query: 'btc',
      ),
    ).called(1);
  });
}
