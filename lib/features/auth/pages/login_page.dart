import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/localization/app_localizations.dart';
import 'package:task_flutter/core/utils/auth_validators.dart';
import 'package:task_flutter/core/widgets/custom_app_bar.dart';
import 'package:task_flutter/core/widgets/custom_elevated_button.dart';
import 'package:task_flutter/features/auth/pages/register_page.dart';
import 'package:task_flutter/features/product/pages/product_list_page.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Login'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(40)),
        child: SingleChildScrollView(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductListPage()), 
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.h(60),),
                  Text('Email' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
                  SizedBox(height: context.h(18),),
                  CustomTextField(
                    hint: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  SizedBox(height: context.h(60)),
                  Text('Password' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
                  SizedBox(height: context.h(18),),
                  CustomTextField(
                    hint: "Password",
                    controller: passwordController,
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  SizedBox(height: context.h(80)),
                  CustomElevatedButton(
                    text: AppLocalizations.of(context).translate("login"),
                   onPressed: (){
                    if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      }
                   }),
                  SizedBox(height: context.h(20)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(fontSize: context.sp(40) , color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
