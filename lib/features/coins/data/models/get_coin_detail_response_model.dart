import 'package:json_annotation/json_annotation.dart';
import 'package:unii_test/features/coins/data/models/coin_detail_model.dart';

part 'get_coin_detail_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetCoinDetailResponseModel {
  const GetCoinDetailResponseModel({
    required this.status,
    required this.data,
  });

  @JsonKey(defaultValue: '')
  final String status;
  final GetCoinDetailDataModel data;

  factory GetCoinDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoinDetailResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoinDetailResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetCoinDetailDataModel {
  const GetCoinDetailDataModel({
    required this.coin,
  });

  final CoinDetailModel coin;

  factory GetCoinDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoinDetailDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoinDetailDataModelToJson(this);
}
