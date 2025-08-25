import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/homepage/signup/cupit/cubit/sign_up_cupit_cubit.dart';
import 'package:movies_mage/homepage/signup/sign_up_body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child:const Scaffold(
        body: SignUpBody(),
      ),
    );
  }
}
