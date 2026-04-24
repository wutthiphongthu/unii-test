import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:unii_test/core/di/injection.dart';
import 'package:unii_test/features/coins/presentation/bloc/coin_detail_bloc.dart';

class CoinDetailBottomSheet extends StatelessWidget {
  const CoinDetailBottomSheet({required this.coinId, super.key});

  final String coinId;

  static Future<void> show(BuildContext context, String coinId) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.72,
          child: CoinDetailBottomSheet(coinId: coinId),
        );
      },
    );
  }

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
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<CoinDetailBloc, CoinDetailState>(
                  builder: (context, state) {
                    if (state.status == CoinDetailStatus.loading ||
                        state.status == CoinDetailStatus.initial) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == CoinDetailStatus.failure ||
                        state.data == null) {
                      return Center(child: Text('Unable to load coin detail'));
                    }

                    final data = state.data!;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data.imageUrl,
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF111111),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: data.name,
                                            style: TextStyle(
                                              color:
                                                  _getColor(data.symbolColor) ??
                                                  Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${data.symbol.toUpperCase()})',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF111111),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'PRICE  ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: currency.format(
                                              data.currentPrice,
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF111111),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'MAKET CAP  ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: _displayMaketCapValue(
                                              data.marketCap,
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              data.description.isEmpty
                                  ? 'No description available.'
                                  : data.description,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8A8A8A),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        TextButton(
                          onPressed: () async {
                            final uri = Uri.parse('https://www.unii.co.th');
                            final success = await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                            if (!context.mounted) return;
                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Unable to open website'),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'GO TO WEBSITE',
                              style: TextStyle(
                                color: Color(0xFFA020F0),
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _displayMaketCapValue(double marketCap) {
    if (marketCap >= 1000000000000) {
      return '\$${(marketCap / 1000000000000).toStringAsFixed(2)} trillion';
    }
    if (marketCap >= 1000000000) {
      return '\$${(marketCap / 1000000000).toStringAsFixed(2)} billion';
    }
    if (marketCap >= 1000000) {
      return '\$${(marketCap / 1000000).toStringAsFixed(2)} million';
    }
    return '\$${marketCap.toStringAsFixed(2)}';
  }

  Color? _getColor(String symbolColor) {
    // Remove the leading '#' if present
    final cleaned = symbolColor.replaceAll('#', '');
    if (cleaned.length == 6) {
      // Add alpha for 100% opacity
      return Color(int.parse('FF$cleaned', radix: 16));
    }
    if (cleaned.length == 8) {
      // Already includes alpha
      return Color(int.parse(cleaned, radix: 16));
    }
    // Not a valid color string
    return null;
  }
}
