import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:unii_test/core/di/injection.dart';
import 'package:unii_test/features/coins/presentation/bloc/coin_detail_bloc.dart';

class CoinDetailPage extends StatelessWidget {
  const CoinDetailPage({required this.coinId, super.key});

  static const String routeName = '/coins/detail';
  final String coinId;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return BlocProvider(
      create: (_) =>
          getIt<CoinDetailBloc>(param1: coinId)..add(const CoinDetailFetched()),
      child: BlocListener<CoinDetailBloc, CoinDetailState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage &&
            current.errorMessage?.isNotEmpty == true,
        listener: (context, state) {
          final message = state.errorMessage ?? 'Unable to load coin detail';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<CoinDetailBloc, CoinDetailState>(
            builder: (context, state) {
              if (state.status == CoinDetailStatus.loading ||
                  state.status == CoinDetailStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = state.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(data.imageUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            data.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '#${data.marketCapRank}  ${data.symbol.toUpperCase()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Current Price: ${currency.format(data.currentPrice)}',
                    ),
                    Text('24h High: ${currency.format(data.high24h)}'),
                    Text('24h Low: ${currency.format(data.low24h)}'),
                    const SizedBox(height: 16),
                    Text(
                      data.description.isNotEmpty
                          ? data.description
                          : 'No description available.',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
