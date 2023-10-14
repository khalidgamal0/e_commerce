import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/search_cubit/search_cubit.dart';
import 'package:shop_app/custom_component/custom_text_form_field.dart';
import 'package:shop_app/views/widgets/list_products_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  GlobalKey<FormState> formKey = GlobalKey();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: 'Search',
                          prefix: Icons.search,
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter text ';
                            } else {
                              return null;
                            }
                          },
                          onSubmit: (String text) {
                            SearchCubit.get(context).search(text);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchLoading)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (SearchCubit.get(context).model?.status == true)
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListItem(
                                    SearchCubit.get(context)
                                        .model
                                        ?.data
                                        ?.data?[index],
                                    SearchCubit.get(context),
                                    isOldPrice: false,
                                  ),
                              separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
