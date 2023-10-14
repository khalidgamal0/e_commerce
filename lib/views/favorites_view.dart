import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/views/widgets/list_products_item.dart';

import '../constant.dart';



class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! FavoritesLoading,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListItem(
              favoritesModel?.data?.data?[index].product,
              HomeCubit.get(context),
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Divider(
                thickness: 1,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount:
               favoritesModel!.data!.data!.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
