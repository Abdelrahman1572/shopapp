// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/ShopApp/Shop_Layouts.dart';
import 'package:shop_app/modules/register/Cubit/cubit.dart';
import 'package:shop_app/modules/register/Cubit/states.dart';
import 'package:shop_app/shared/component/Components.dart';
import 'package:shop_app/shared/component/Constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                  key: token, value: state.loginModel.data!.token)
                  .then((value) {
                token =  state.loginModel.data!.token!;
                NavigateAndFinish(context, const ShopLayout()
                );
              });
            } else {
              print(state.loginModel.message);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Register Now To Browse our Hot Offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          Controller: nameController,
                          Type: TextInputType.name,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          Label: 'UserName',
                          Prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DefaultFormField(
                          Controller: emailController,
                          Type: TextInputType.emailAddress,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                          Label: 'Email',
                          Prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DefaultFormField(
                          Controller: passwordController,
                          Type: TextInputType.visiblePassword,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixpressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          Label: 'Password',
                          Prefix: Icons.password_outlined,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DefaultFormField(
                          Controller: phoneController,
                          Type: TextInputType.phone,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          Label: 'Phone',
                          Prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                            condition: State is! ShopRegisterLoadingState, //state is! ShopLoginLoadingState,
                            builder: (context) => Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
