import 'package:injectable/injectable.dart';
import 'package:unii_test/features/coins/domain/entities/coin_detail_entity.dart';
import 'package:unii_test/features/coins/domain/repositories/coin_repository.dart';

@lazySingleton
class GetCoinDetailUseCase {
  const GetCoinDetailUseCase(this._repository);

  final CoinRepository _repository;

  Future<CoinDetailEntity> call(String coinId) {
    return _repository.getCoinDetail(
      coinId: coinId,
    );
  }
}
