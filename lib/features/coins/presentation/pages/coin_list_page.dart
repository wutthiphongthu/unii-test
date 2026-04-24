import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unii_test/core/di/injection.dart';
import 'package:unii_test/features/coins/domain/entities/coin_entity.dart';
import 'package:unii_test/features/coins/presentation/bloc/coin_list_bloc.dart';
import 'package:unii_test/features/coins/presentation/widgets/coin_card.dart';
import 'package:unii_test/features/coins/presentation/widgets/coin_detail_bottom_sheet.dart';
import 'package:unii_test/features/coins/presentation/widgets/top_rank_section.dart';

class CoinListPage extends StatefulWidget {
  const CoinListPage({super.key});

  @override
  State<CoinListPage> createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  late final ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();
  late CoinListBloc coinListBloc;
  @override
  void initState() {
    super.initState();
    coinListBloc = getIt<CoinListBloc>();
    coinListBloc.add(const CoinListFetched());
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    // เช็คว่ามี client ที่กำลังฟังอยู่กับ ScrollController หรือไม่
    if (!_scrollController.hasClients) {
      return;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // เช็คว่ามีการ scroll ไปถึงประมาณ 90% ของความสูงของหน้าเว็บ
    if (currentScroll >= maxScroll * 0.9) {
      coinListBloc.add(const CoinListLoadMoreRequested());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openCoinDetail(CoinEntity coin) {
    CoinDetailBottomSheet.show(context, coin.id);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocProvider(
      create: (_) => coinListBloc,
      child: BlocListener<CoinListBloc, CoinListState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage &&
            current.errorMessage?.isNotEmpty == true,
        listener: (context, state) {
          final message = state.errorMessage ?? 'Something went wrong';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Coins')),
          body: SafeArea(
            child: BlocBuilder<CoinListBloc, CoinListState>(
              builder: (context, state) {
                if (state.status == CoinListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    coinListBloc.add(const CoinListFetched(isRefresh: true));
                    await coinListBloc.stream.firstWhere(
                      (s) => !s.isRefreshing,
                    );
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) =>
                                coinListBloc.add(CoinListSearchChanged(value)),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffeeeeee),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: SvgPicture.asset(
                                  'assets/icons/search.svg',
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        _searchController.clear();
                                        coinListBloc.add(
                                          CoinListSearchChanged(''),
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/icons/delete.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    )
                                  : null,
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (state.shouldShowTopRank)
                        SliverToBoxAdapter(
                          child: TopRankSection(
                            items: state.topRankItems,
                            onCoinTapped: _openCoinDetail,
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: state.filteredItems.isNotEmpty
                              ? Text(
                                  state.shouldShowTopRank
                                      ? 'Buy, sell and hold crypto'
                                      : 'Search Results',
                                  textAlign: isLandscape
                                      ? TextAlign.center
                                      : TextAlign.start,
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              : SizedBox.shrink(),
                        ),
                      ),
                      if (state.filteredItems.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/unii_empty.svg',
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Sorry',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  'No result match for this keyword',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (state.filteredItems.isNotEmpty && isLandscape)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          sliver: SliverGrid.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.8,
                                ),
                            itemCount: state.filteredItems.length,
                            itemBuilder: (context, index) {
                              final coin = state.filteredItems[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: CoinCard(
                                  coin: coin,
                                  onTap: () => _openCoinDetail(coin),
                                ),
                              );
                            },
                          ),
                        )
                      else if (state.filteredItems.isNotEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          sliver: SliverList.builder(
                            itemCount: state.filteredItems.length,
                            itemBuilder: (context, index) {
                              final coin = state.filteredItems[index];
                              return CoinCard(
                                coin: coin,
                                onTap: () => _openCoinDetail(coin),
                              );
                            },
                          ),
                        ),
                      if (state.filteredItems.isNotEmpty)
                        SliverToBoxAdapter(
                          child: state.isLoadingMore
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox(height: 12),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
