import 'package:injectable/injectable.dart';
import 'package:unii_test/core/constants/app_constants.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';
import 'package:unii_test/features/coins/domain/repositories/coin_repository.dart';

@lazySingleton
class GetCoinsUseCase {
  const GetCoinsUseCase(this._repository);

  final CoinRepository _repository;

  Future<List<CoinEntity>> call({
    required int page,
    int perPage = AppConstants.pageSize,
    String query = '',
  }) {
    return _repository.getCoins(
      page: page,
      perPage: perPage,
      query: query,
    );
  }
}
