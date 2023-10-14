import 'package:flutter/material.dart';
import 'package:shop_app/constant.dart';


Widget buildListItem(model, cubit, {bool isOldPrice = true }) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.network(
                model.image!,
                width: 120,
                height: 120,
              ),
              if (model.discount != 0 && isOldPrice)
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
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Text(
                      model.price!.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice!.toString(),
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
                         favorites[model.id] ==
                          true
                          ? kPrimaryColor
                          : Colors.grey,
                      child: IconButton(
                        onPressed: () {

                          cubit.changeFavorites(model.id!);
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
    ),
  );
}