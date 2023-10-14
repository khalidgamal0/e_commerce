import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/cubits/register_cubit/register_cubit.dart';
import 'package:shop_app/custom_component/custom_button.dart';
import 'package:shop_app/custom_component/custom_text_form_field.dart';
import 'package:shop_app/custom_component/snack_bar.dart';
import 'package:shop_app/helper/shared_preferences.dart';

import 'home_view.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey();

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context, state) {
          if(state is RegisterSuccess){
            if(state.loginModel.status){

              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                token = state.loginModel.data?.token;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                  return const HomeView();
                },), (route) => false);

              });

            }else{
              showSnackBarMessage(context,state.loginModel.message!, Colors.red, Colors.white);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics:const  BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
                          style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomTextFormField(
                          controller: nameController,
                          label: 'Name',
                          prefix: Icons.person,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          controller: emailController,
                          label: 'Email Address',
                          prefix: Icons.mail_lock_outlined,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          suffixPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          suffix: RegisterCubit.get(context).suffix,
                          isPassword:RegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          controller: phoneController,
                          label: 'Phone Number',
                          prefix: Icons.phone,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is !RegisterLoading,
                          builder: (context) => CustomButton(
                            buttonName: 'Register'.toUpperCase(),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
