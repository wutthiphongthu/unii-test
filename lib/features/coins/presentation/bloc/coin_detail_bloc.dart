import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:unii_test/features/coins/domain/entities/coin_detail_entity.dart';
import 'package:unii_test/features/coins/domain/usecases/get_coin_detail_usecase.dart';

part 'coin_detail_event.dart';
part 'coin_detail_state.dart';

@injectable
class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  CoinDetailBloc({
    @factoryParam required String coinId,
    required GetCoinDetailUseCase getCoinDetailUseCase,
  })  : _coinId = coinId,
        _getCoinDetailUseCase = getCoinDetailUseCase,
        super(const CoinDetailState()) {
    on<CoinDetailFetched>(_onFetched);
  }

  final String _coinId;
  final GetCoinDetailUseCase _getCoinDetailUseCase;

  Future<void> _onFetched(
    CoinDetailFetched event,
    Emitter<CoinDetailState> emit,
  ) async {
    emit(state.copyWith(status: CoinDetailStatus.loading, errorMessage: null));
    try {
      final detail = await _getCoinDetailUseCase(_coinId);
      emit(
        state.copyWith(
          status: CoinDetailStatus.success,
          data: detail,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CoinDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
