import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/Components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit searchCubit = SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      DefaultFormField(
                          Controller: searchController,
                          Type: TextInputType.text,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          // onSubmit: (String text){
                          //   SearchCubit.get(context).search(text);
                          // },
                          onChange: (String text) {
                            SearchCubit.get(context).search(text);
                          },
                          Label: 'Search',
                          Prefix: Icons.search_rounded),
                      const SizedBox(height: 10),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 10),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              SearchModel model =
                                  searchCubit.allSearchProducets[index];
                              return _buildSearchItem(context, model);
                            },
                            separatorBuilder: (context, index) => MyDivider(),
                            itemCount: searchCubit.allSearchProducets.length,
                          ),
                        )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _buildSearchItem(BuildContext context, SearchModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        width: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                            fontSize: 17, height: 1.4, color: Colors.blueGrey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
