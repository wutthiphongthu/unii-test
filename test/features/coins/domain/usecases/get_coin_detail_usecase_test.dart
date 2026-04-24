import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unii_test/features/coins/domain/entities/coin_detail_entity.dart';
import 'package:unii_test/features/coins/domain/repositories/coin_repository.dart';
import 'package:unii_test/features/coins/domain/usecases/get_coin_detail_usecase.dart';

class _MockCoinRepository extends Mock implements CoinRepository {}

void main() {
  late CoinRepository repository;
  late GetCoinDetailUseCase useCase;

  setUp(() {
    repository = _MockCoinRepository();
    useCase = GetCoinDetailUseCase(repository);
  });

  test('returns coin detail from repository', () async {
    const expected = CoinDetailEntity(
      id: 'bitcoin',
      symbol: 'btc',
      name: 'Bitcoin',
      description: 'Bitcoin detail',
      imageUrl: 'https://example.com/btc.png',
      websiteUrl: 'https://bitcoin.org',
      currentPrice: 100000,
      marketCap: 2000000000,
      marketCapRank: 1,
      high24h: 5000000,
      low24h: 1,
      symbolColor: '#f7931A',
    );

    when(
      () => repository.getCoinDetail(coinId: 'bitcoin'),
    ).thenAnswer((_) async => expected);

    final result = await useCase('bitcoin');

    expect(result, expected);
    verify(() => repository.getCoinDetail(coinId: 'bitcoin')).called(1);
  });
}
