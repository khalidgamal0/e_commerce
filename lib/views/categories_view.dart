import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategoryItem(
                HomeCubit.get(context).categoriesModel?.data.data[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount:
                HomeCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }
}

Widget buildCategoryItem(DataModel? model) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Image.network(
          model!.image,
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios_outlined,
        )
      ],
    ),
  );
}
