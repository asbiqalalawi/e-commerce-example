import 'package:e_commerce_example/app/widget/input.dart';
import 'package:e_commerce_example/feature/search/bloc/search_bloc.dart';
import 'package:e_commerce_example/feature/search/view/widget/search_product_cart.dart';
import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(GetSearchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: ColorStyle.mainColor,
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Input(
              labelText: 'Search',
              controller: _searchController,
              autoFocus: true,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<SearchBloc>().add(GetSearchEvent(search: _searchController.text));
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            state.products.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                                    itemCount: state.products.length,
                                    itemBuilder: (context, index) => SearchProductCard(
                                      product: state.products[index],
                                    ),
                                  )
                                : Center(
                                    child: Text(_searchController.text == '' ? 'Search something' : 'Not Found'),
                                  ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
