import 'package:injectable/injectable.dart';
import 'package:unii_test/core/network/dio_client.dart';
import 'package:unii_test/core/constants/app_constants.dart';
import 'package:unii_test/features/coins/data/models/coin_detail_model.dart';
import 'package:unii_test/features/coins/data/models/coin_model.dart';
import 'package:unii_test/features/coins/data/models/get_coin_detail_response_model.dart';
import 'package:unii_test/features/coins/data/models/get_coins_response_model.dart';

@lazySingleton
class CoinRemoteDataSource {
  const CoinRemoteDataSource(this._dioClient);

  final DioClient _dioClient;

  Future<List<CoinModel>> getCoins({
    required int page,
    required int perPage,
    String query = '',
  }) async {
    final response = await _dioClient.dio.get<Map<String, dynamic>>(
      '${AppConstants.apiVersion}/coins',
      queryParameters: <String, dynamic>{
        'limit': perPage,
        'offset': (page - 1) * perPage,
        if (query.trim().isNotEmpty) 'search': query.trim(),
      },
    );
    final model = GetCoinsResponseModel.fromJson(
      response.data ?? <String, dynamic>{},
    );
    return model.data.coins;
  }

  Future<CoinDetailModel> getCoinDetail({
    required String coinId,
  }) async {
    final response = await _dioClient.dio.get<Map<String, dynamic>>(
      '${AppConstants.apiVersion}/coin/$coinId',
    );
    final model = GetCoinDetailResponseModel.fromJson(
      response.data ?? <String, dynamic>{},
    );
    return model.data.coin;
  }
}
