import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/localization/app_localizations.dart';
import 'package:task_flutter/core/utils/responsive.dart';
import 'package:task_flutter/core/widgets/custom_app_bar.dart';
import 'package:task_flutter/core/widgets/custom_elevated_button.dart';
import 'package:task_flutter/features/auth/pages/login_page.dart';
import 'package:task_flutter/features/profile/cubit/profile_cubit.dart';
import 'package:task_flutter/features/profile/cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().fetchProfile();

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: context.w(30), vertical: context.h(30)),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: context.w(250),
                    backgroundImage:
                        state.photoUrl != null ? NetworkImage(state.photoUrl!) : null,
                    child: state.photoUrl == null
                        ? Icon(Icons.person, size: context.sp(100))
                        : null,
                  ),
                  SizedBox(height: context.h(60)),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                        height: context.h(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.w(30)),
                          color: const Color.fromARGB(255, 238, 236, 236)
                        ),
                    child: Padding(
                      padding: EdgeInsets.all(context.w(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Name: ",
                              style: TextStyle(
                                  fontSize: context.sp(50),
                                  fontWeight: FontWeight.bold)),
                                  SizedBox(width: context.w(10),),
                          Text(state.name, style: TextStyle(fontSize: context.sp(50))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.h(60)),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                        height: context.h(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.w(30)),
                          color: const Color.fromARGB(255, 238, 236, 236)
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Email: ",
                            style: TextStyle(
                                fontSize: context.sp(50),
                                fontWeight: FontWeight.bold)),
                                SizedBox(width: context.w(10),),
                        Text(state.email, style: TextStyle(fontSize: context.sp(50))),
                      ],
                    ),
                  ),
                  SizedBox(height: context.h(80)),
                  CustomElevatedButton
                  (text: AppLocalizations.of(context).translate("logout"),
                  onPressed: ()async{
                    await context.read<ProfileCubit>().logout(context);
                  })
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
