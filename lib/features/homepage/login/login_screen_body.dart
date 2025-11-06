// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/core/widgets/custom_button.dart';
import 'package:movies_mage/core/widgets/custom_text_field.dart';
import 'package:movies_mage/features/homepage/login/cupit/logincupit_cubit.dart';
import 'package:movies_mage/features/homepage/login/cupit/logincupit_state.dart';
import 'package:movies_mage/features/homepage/home_screen.dart';
import 'package:movies_mage/features/homepage/signup/sign_up_view.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

@override
Widget build(BuildContext context) {
  return BlocConsumer<LoginCubit, LoginState>(
    listener: (context, state) {
      if (state is LoginWithEmailSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged in successfully')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (state is LoginWithGoogleSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged in with Google')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (state is LogoutSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged out successfully')));
      } else if (state is LoginWithEmailfailed ||
          state is LoginWithGooglefailed ||
          state is Logoutfailed) {
        final error = (state as dynamic).error;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $error')));
      }
    },
    builder: (context, state) {
      return Scaffold(
        body: Stack(
          children: [
            // 🔹 Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/login_background.jpg"), // put your image here
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔹 Semi-transparent overlay (for better contrast)
            Container(
              color: Colors.black.withOpacity(0.6),
            ),

            // 🔹 Foreground content (your login form)
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo + App Name
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/mylogo2-removebg-preview.png",
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Movies Mage",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Welcome Text
                      const Text(
                        "Hi, Welcome Again",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Sign in to continue watching your favorites!",
                        style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                      ),
                      const SizedBox(height: 40),

                      // Email
                      CustumTextField(
                        hint: 'Enter Your Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),

                      // Password
                      CustumTextField(
                        hint: 'Enter Your Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      Custumbuttton(
                        color: kPrimaryColor,
                        text: state is LoginWithEmailLoading
                            ? 'Logging in...'
                            : 'Login',
                        onPressed: () {
                          context.read<LoginCubit>().signInWithEmail(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(color: Colors.grey, thickness: 0.5),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "OR",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: Colors.grey, thickness: 0.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Google Login
                      Custumbuttton(
                        myicon:
                            Image.asset("assets/Google_Icons-09-512.webp"),
                        color: Colors.white,
                        text: state is LoginWithGoogleLoading
                            ? 'Logging in with Google...'
                            : 'Login with Google',
                        onPressed: () {
                          context.read<LoginCubit>().signInWithGoogle();
                        },
                      ),
                      const SizedBox(height: 30),

                      // Sign Up Redirect
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

}
