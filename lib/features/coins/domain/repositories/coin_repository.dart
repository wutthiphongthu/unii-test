import 'package:unii_test/features/coins/domain/entities/coin_detail_entity.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';

abstract class CoinRepository {
  Future<List<CoinEntity>> getCoins({
    required int page,
    required int perPage,
    String query = '',
  });

  Future<CoinDetailEntity> getCoinDetail({
    required String coinId,
  });
}
