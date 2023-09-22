import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/Cubit/Cubit.dart';
import 'package:shop_app/shared/Cubit/States.dart';
import 'package:shop_app/shared/component/Components.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Masrawy'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(onPressed: (){
                  NavigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search)),
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentindex,
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined),label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],),
        );
      },
    );
  }
}
