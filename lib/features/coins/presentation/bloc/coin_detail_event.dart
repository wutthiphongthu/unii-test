part of 'coin_detail_bloc.dart';

sealed class CoinDetailEvent {
  const CoinDetailEvent();
}

class CoinDetailFetched extends CoinDetailEvent {
  const CoinDetailFetched();
}
