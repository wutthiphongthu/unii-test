part of 'coin_list_bloc.dart';

sealed class CoinListEvent {
  const CoinListEvent();
}

class CoinListFetched extends CoinListEvent {
  const CoinListFetched({this.isRefresh = false});
  final bool isRefresh;
}

class CoinListLoadMoreRequested extends CoinListEvent {
  const CoinListLoadMoreRequested();
}

class CoinListSearchChanged extends CoinListEvent {
  const CoinListSearchChanged(this.query);
  final String query;
}

class CoinListAutoRefreshRequested extends CoinListEvent {
  const CoinListAutoRefreshRequested();
}
