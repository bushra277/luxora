import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/app.dart';
import 'package:task_flutter/core/localization/language_cubit.dart';
import 'package:task_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:task_flutter/features/auth/service/auth_service.dart';
import 'package:task_flutter/features/category/cuibt/category_cubit.dart';
import 'package:task_flutter/features/category/repository/category_reposity.dart';
import 'package:task_flutter/features/category/services/category_service.dart';
import 'package:task_flutter/features/product/cubit/product_cubit.dart';
import 'package:task_flutter/features/product/service/product_service.dart';
import 'package:task_flutter/features/profile/cubit/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); 

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(AuthService()),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => ProductCubit(ProductService()),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => CategoryCubit(CategoryRepository(CategoryService()))),
        BlocProvider(create: (_) => ProfileCubit()..fetchProfile()),
        BlocProvider(create: (_) => LanguageCubit())
      ],
      child: MyApp(),
    ),
  );
}
