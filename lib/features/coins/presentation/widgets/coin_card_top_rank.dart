import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';

class CoinCardTopRank extends StatelessWidget {
  final CoinEntity coin;
  final VoidCallback onTap;
  const CoinCardTopRank({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final changeColor = coin.priceChangePercentage24h >= 0
        ? Color(0xff13BC24)
        : Color(0xffF82D2D);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 140,
        margin: EdgeInsets.all(4),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 4),
        decoration: BoxDecoration(
          color: const Color(0xffDFCFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(coin.imageUrl, width: 40, height: 40),
            const SizedBox(height: 4),
            Text(
              coin.symbol,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              coin.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 68,
              height: 30,
              decoration: BoxDecoration(
                color: changeColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
