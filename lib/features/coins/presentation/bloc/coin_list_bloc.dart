import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:unii_test/core/constants/app_constants.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';
import 'package:unii_test/features/coins/domain/usecases/get_coins_usecase.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

@injectable
class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc({required GetCoinsUseCase getCoinsUseCase})
    : _getCoinsUseCase = getCoinsUseCase,
      super(const CoinListState()) {
    on<CoinListFetched>(_onFetched);
    on<CoinListLoadMoreRequested>(_onLoadMoreRequested);
    on<CoinListSearchChanged>(_onSearchChanged);
    on<CoinListAutoRefreshRequested>(_onAutoRefreshRequested);
    _autoRefreshTimer = Timer.periodic(
      AppConstants.autoRefreshInterval,
      (_) => add(const CoinListAutoRefreshRequested()),
    );
  }

  final GetCoinsUseCase _getCoinsUseCase;
  Timer? _autoRefreshTimer;

  Future<void> _onFetched(
    CoinListFetched event,
    Emitter<CoinListState> emit,
  ) async {
    final isInitialLoad = state.status == CoinListStatus.initial;
    emit(
      state.copyWith(
        status: isInitialLoad ? CoinListStatus.loading : state.status,
        isRefreshing: event.isRefresh,
        errorMessage: null,
      ),
    );

    try {
      final items = await _getCoinsUseCase(page: 1, query: state.query);
      emit(
        state.copyWith(
          status: CoinListStatus.success,
          items: items,
          page: 1,
          hasMore: items.length >= AppConstants.pageSize,
          isRefreshing: false,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CoinListStatus.failure,
          isRefreshing: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMoreRequested(
    CoinListLoadMoreRequested event,
    Emitter<CoinListState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final nextPage = state.page + 1;
    try {
      final nextItems = await _getCoinsUseCase(
        page: nextPage,
        query: state.query,
      );
      emit(
        state.copyWith(
          status: CoinListStatus.success,
          items: <CoinEntity>[...state.items, ...nextItems],
          page: nextPage,
          hasMore: nextItems.length >= AppConstants.pageSize,
          isLoadingMore: false,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(isLoadingMore: false, errorMessage: error.toString()),
      );
    }
  }

  void _onSearchChanged(
    CoinListSearchChanged event,
    Emitter<CoinListState> emit,
  ) async {
    emit(state.copyWith(query: event.query, page: 1, hasMore: true));
    add(const CoinListFetched());
  }

  Future<void> _onAutoRefreshRequested(
    CoinListAutoRefreshRequested event,
    Emitter<CoinListState> emit,
  ) async {
    if (state.status != CoinListStatus.success || state.items.isEmpty) {
      return;
    }

    try {
      final refreshedItems = await _getCoinsUseCase(
        page: 1,
        perPage: state.items.length.clamp(1, 100).toInt(),
        query: state.query,
      );
      if (refreshedItems.isEmpty) {
        return;
      }
      final refreshedMap = <String, CoinEntity>{
        for (final coin in refreshedItems) coin.id: coin,
      };
      final updated = state.items
          .map(
            (coin) => coin.copyWith(
              currentPrice:
                  refreshedMap[coin.id]?.currentPrice ?? coin.currentPrice,
              priceChangePercentage24h:
                  refreshedMap[coin.id]?.priceChangePercentage24h ??
                  coin.priceChangePercentage24h,
            ),
          )
          .toList();
      emit(state.copyWith(items: updated));
    } catch (_) {
      // Silent fail for background auto refresh.
    }
  }

  @override
  Future<void> close() {
    _autoRefreshTimer?.cancel();
    return super.close();
  }
}
