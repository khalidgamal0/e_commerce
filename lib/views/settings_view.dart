import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/home_cubit/home_cubit.dart';
import 'package:shop_app/custom_component/custom_button.dart';
import 'package:shop_app/custom_component/custom_text_form_field.dart';
import 'package:shop_app/custom_component/navigator_push_remove_until.dart';
import 'package:shop_app/helper/shared_preferences.dart';
import 'package:shop_app/views/login_view.dart';

import '../custom_component/snack_bar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  String? e;
  String ? n;
  String ? p;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      if (state is UpdateUserDataSuccess) {
        if (state.loginModel.status) {
          showSnackBarMessage(
              context, state.loginModel.message!, Colors.green, Colors.white);
        } else {
          showSnackBarMessage(
              context, state.loginModel.message!, Colors.red, Colors.white);
        }
      }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) {
            var model = HomeCubit.get(context).userModel;
            if (model?.status != false) {
              emailController.text = model!.data!.email;
              nameController.text = model.data!.name;
              phoneController.text = model.data!.phone;
              e = emailController.text;
              n = nameController.text;
              p = phoneController.text;
            } else {
              emailController.text = e!;
              nameController.text = n!;
              phoneController.text = p!;
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is UpdateUserDataLoading)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Name',
                        prefix: Icons.person,
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Email Address',
                        prefix: Icons.mail,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Phone Number',
                        prefix: Icons.phone,
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        buttonName: 'LogOut'.toUpperCase(),
                        onTap: () {
                          CacheHelper.removeData(key: 'token').then((value) {
                            navigatorAndFinish(const LoginView(), context);
                          });
                          HomeCubit.get(context).currentIndex = 0;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        buttonName: 'Update Profile'.toUpperCase(),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.get(context).updateUserData(
                              email: emailController.text,
                              phone: phoneController.text,
                              name: nameController.text,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
