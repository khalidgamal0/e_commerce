import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/custom_component/snack_bar.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ChangeFavoriteSuccess) {
          if (state.model?.status == false) {
            showSnackBarMessage(
                context, state.model!.message, Colors.red, Colors.white);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoriesModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => builderWidget(HomeCubit.get(context).homeModel,
              HomeCubit.get(context).categoriesModel, context),
        );
      },
    );
  }
}

Widget builderWidget(
    HomeModel? homeModel, CategoriesModel? categoriesModel, context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: homeModel?.data.banners.map(
            (e) {
              return Image(
                image: NetworkImage(e.image),
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Categories',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesModel!.data.data.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  itemBuilder: (context, index) =>
                      buildCategoriesListView(categoriesModel.data.data[index]),
                ),
              ),
              const SizedBox(height: 20),
              const Text('New Products',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            childAspectRatio: 1 / 1.6,
            crossAxisSpacing: 1,
            children: List.generate(
              homeModel!.data.products.length,
              (index) {
                return buildGridView(homeModel.data.products[index], context);
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoriesListView(DataModel model) {
  return Stack(
    children: [
      Image.network(
        model.image,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: 0,
        child: Container(
          alignment: Alignment.center,
          width: 100,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildGridView(ProductsModel model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              model.image,
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
              Positioned(
                bottom: 0,
                child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                            fontSize: 9.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor:
                        favorites[model.id] == true
                            ? kPrimaryColor
                            : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        HomeCubit.get(context).changeFavorites(model.id);
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
