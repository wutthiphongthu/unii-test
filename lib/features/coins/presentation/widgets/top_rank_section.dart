import 'package:flutter/material.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';
import 'package:unii_test/features/coins/presentation/widgets/coin_card_top_rank.dart';

class TopRankSection extends StatelessWidget {
  const TopRankSection({
    required this.items,
    required this.onCoinTapped,
    super.key,
  });

  final List<CoinEntity> items;
  final ValueChanged<CoinEntity> onCoinTapped;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      crossAxisAlignment: isLandscape
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Top',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000),
                  ),
                ),
                TextSpan(
                  text: ' 3 ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFAD3939),
                  ),
                ),
                TextSpan(
                  text: 'rank crypto ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...items.map(
                (coin) => CoinCardTopRank(
                  coin: coin,
                  onTap: () => onCoinTapped(coin),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
