part of 'coin_list_bloc.dart';

enum CoinListStatus { initial, loading, success, failure }

class CoinListState extends Equatable {
  const CoinListState({
    this.status = CoinListStatus.initial,
    this.items = const <CoinEntity>[],
    this.query = '',
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.errorMessage,
  });

  final CoinListStatus status;
  final List<CoinEntity> items;
  final String query;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isRefreshing;
  final String? errorMessage;

  List<CoinEntity> get topRankItems {
    final sorted = List<CoinEntity>.of(items)
      ..sort((a, b) => a.marketCapRank.compareTo(b.marketCapRank));
    return sorted.take(3).toList();
  }

  List<CoinEntity> get filteredItems {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return items;
    }
    return items
        .where(
          (coin) =>
              coin.name.toLowerCase().contains(normalizedQuery) ||
              coin.symbol.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }

  bool get shouldShowTopRank => query.trim().isEmpty;

  CoinListState copyWith({
    CoinListStatus? status,
    List<CoinEntity>? items,
    String? query,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isRefreshing,
    String? errorMessage,
  }) {
    return CoinListState(
      status: status ?? this.status,
      items: items ?? this.items,
      query: query ?? this.query,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        query,
        page,
        hasMore,
        isLoadingMore,
        isRefreshing,
        errorMessage,
      ];
}
