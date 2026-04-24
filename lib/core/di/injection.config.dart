// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/coins/data/datasources/coin_remote_data_source.dart'
    as _i465;
import '../../features/coins/data/repositories/coin_repository_impl.dart'
    as _i531;
import '../../features/coins/domain/repositories/coin_repository.dart' as _i919;
import '../../features/coins/domain/usecases/get_coin_detail_usecase.dart'
    as _i646;
import '../../features/coins/domain/usecases/get_coins_usecase.dart' as _i811;
import '../../features/coins/presentation/bloc/coin_detail_bloc.dart' as _i145;
import '../../features/coins/presentation/bloc/coin_list_bloc.dart' as _i333;
import '../network/dio_client.dart' as _i667;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i667.DioClient>(() => _i667.DioClient());
    gh.lazySingleton<_i465.CoinRemoteDataSource>(
      () => _i465.CoinRemoteDataSource(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i919.CoinRepository>(
      () => _i531.CoinRepositoryImpl(gh<_i465.CoinRemoteDataSource>()),
    );
    gh.lazySingleton<_i646.GetCoinDetailUseCase>(
      () => _i646.GetCoinDetailUseCase(gh<_i919.CoinRepository>()),
    );
    gh.lazySingleton<_i811.GetCoinsUseCase>(
      () => _i811.GetCoinsUseCase(gh<_i919.CoinRepository>()),
    );
    gh.factory<_i333.CoinListBloc>(
      () => _i333.CoinListBloc(getCoinsUseCase: gh<_i811.GetCoinsUseCase>()),
    );
    gh.factoryParam<_i145.CoinDetailBloc, String, dynamic>(
      (coinId, _) => _i145.CoinDetailBloc(
        coinId: coinId,
        getCoinDetailUseCase: gh<_i646.GetCoinDetailUseCase>(),
      ),
    );
    return this;
  }
}
