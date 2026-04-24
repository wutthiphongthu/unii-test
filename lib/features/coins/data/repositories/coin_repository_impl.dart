import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:unii_test/features/coins/data/datasources/coin_remote_data_source.dart';
import 'package:unii_test/features/coins/domain/entities/coin_detail_entity.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';
import 'package:unii_test/features/coins/domain/repositories/coin_repository.dart';

@LazySingleton(as: CoinRepository)
class CoinRepositoryImpl implements CoinRepository {
  const CoinRepositoryImpl(this._remoteDataSource);

  final CoinRemoteDataSource _remoteDataSource;

  @override
  Future<List<CoinEntity>> getCoins({
    required int page,
    required int perPage,
    String query = '',
  }) async {
    try {
      final models = await _remoteDataSource.getCoins(
        page: page,
        perPage: perPage,
        query: query,
      );
      return models.map((model) => model.toEntity()).toList();
    } on DioException catch (error) {
      throw Exception(error.message ?? 'Failed to fetch coin list');
    }
  }

  @override
  Future<CoinDetailEntity> getCoinDetail({
    required String coinId,
  }) async {
    try {
      final model = await _remoteDataSource.getCoinDetail(
        coinId: coinId,
      );
      return model.toEntity();
    } on DioException catch (error) {
      throw Exception(error.message ?? 'Failed to fetch coin detail');
    }
  }
}
