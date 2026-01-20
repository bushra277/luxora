import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/localization/app_localizations.dart';
import 'package:task_flutter/core/utils/auth_validators.dart';
import 'package:task_flutter/core/utils/responsive.dart';
import 'package:task_flutter/core/widgets/custom_app_bar.dart';
import 'package:task_flutter/core/widgets/custom_elevated_button.dart';
import 'package:task_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:task_flutter/features/auth/pages/login_page.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Register'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(40)),
        child: SingleChildScrollView(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
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
                  Text('Name' , style: TextStyle(fontSize: context.sp(50) , fontWeight: FontWeight.bold),),
                  SizedBox(height: context.h(18),),
                  CustomTextField(
                    hint: "Name",
                    controller: nameController,
                    validator: (v) => Validators.requiredField(v, "Name"),
                  ),
                  SizedBox(height: context.h(60)),
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
                    text: AppLocalizations.of(context).translate("Register"), 
                    onPressed:(){
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                    }
                    }),
                  SizedBox(height: context.h(80)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: Text("Already have an account? Login",
                        style: TextStyle(fontSize: context.sp(40) , color: Colors.black)),
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

