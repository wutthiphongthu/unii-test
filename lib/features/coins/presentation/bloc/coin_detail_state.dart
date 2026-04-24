part of 'coin_detail_bloc.dart';

enum CoinDetailStatus { initial, loading, success, failure }

class CoinDetailState extends Equatable {
  const CoinDetailState({
    this.status = CoinDetailStatus.initial,
    this.data,
    this.errorMessage,
  });

  final CoinDetailStatus status;
  final CoinDetailEntity? data;
  final String? errorMessage;

  CoinDetailState copyWith({
    CoinDetailStatus? status,
    CoinDetailEntity? data,
    String? errorMessage,
  }) {
    return CoinDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
