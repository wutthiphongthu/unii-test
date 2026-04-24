// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_coin_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCoinDetailResponseModel _$GetCoinDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => GetCoinDetailResponseModel(
  status: json['status'] as String? ?? '',
  data: GetCoinDetailDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetCoinDetailResponseModelToJson(
  GetCoinDetailResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data.toJson(),
};

GetCoinDetailDataModel _$GetCoinDetailDataModelFromJson(
  Map<String, dynamic> json,
) => GetCoinDetailDataModel(
  coin: CoinDetailModel.fromJson(json['coin'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetCoinDetailDataModelToJson(
  GetCoinDetailDataModel instance,
) => <String, dynamic>{'coin': instance.coin.toJson()};
