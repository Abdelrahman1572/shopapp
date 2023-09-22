import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cateogries_model.dart';
import 'package:shop_app/shared/Cubit/Cubit.dart';
import 'package:shop_app/shared/Cubit/States.dart';
import 'package:shop_app/shared/component/Components.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);
        return shopCubit.allCategores.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  CategoryModel model = shopCubit.allCategores[index];
                return  buildCatItem(model,context);
                },
                separatorBuilder: (context, index) => MyDivider(),
                itemCount: shopCubit.allCategores.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildCatItem(CategoryModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
                image: NetworkImage(model.image!),
                width: 90,
                height: 90,
                fit: BoxFit.cover),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
