import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/Cubit/Cubit.dart';
import 'package:shop_app/shared/Cubit/States.dart';
import 'package:shop_app/shared/component/Components.dart';
import 'package:shop_app/shared/component/Constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                  DefaultFormField(
                      Controller: nameController,
                      Type: TextInputType.name,
                      Validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      Label: 'Name',
                      Prefix: Icons.person),
                  const SizedBox(height: 20,),
                  DefaultFormField(
                      Controller: emailController,
                      Type: TextInputType.emailAddress,
                      Validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      Label: 'Email',
                      Prefix: Icons.email_rounded),
                  const SizedBox(height: 20,),
                  DefaultFormField(
                      Controller: phoneController,
                      Type: TextInputType.phone,
                      Validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      Label: 'Phone',
                      Prefix: Icons.local_phone_rounded),
                  const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       width: 180,
                       decoration: const BoxDecoration(
                         color: Colors.blueGrey,
                         borderRadius:
                         BorderRadius.all(Radius.circular(15)),
                       ),
                       child: TextButton(
                         onPressed: () {
                           if(formKey.currentState!.validate()){
                             ShopCubit.get(context).updateUserData(
                                 name: nameController.text,
                                 email: emailController.text,
                                 phone: phoneController.text);
                           }
                         },
                         child: const Text(
                           'Update',
                           style: TextStyle(
                               color: Colors.white, fontSize: 18),
                         ),
                       ),
                     ),
                     Container(
                       width: 180,
                       decoration: const BoxDecoration(
                         color: Colors.blueGrey,
                         borderRadius:
                         BorderRadius.all(Radius.circular(15)),
                       ),
                       child: TextButton(
                         onPressed: () {
                           signOut(context);
                         },
                         child: const Text(
                           'Logout',
                           style: TextStyle(
                               color: Colors.white, fontSize: 18),
                         ),
                       ),
                     ),
                   ],
                 ),
                ],
              ),
            ),
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
