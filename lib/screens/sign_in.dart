// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta/firbase_services/auth.dart';
import 'package:insta/screens/register.dart';
import 'package:insta/shared/colors.dart';

import '../shared/contants.dart';
import '../shared/snack_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;



  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signIn() async {
    setState(() {
      isLoading = true;
    });

    await AuthMethods().signIn(
        emailll: emailController.text,
        passworddd: passwordController.text,
        context: context);

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;
    showSnackBar(context, "successfully sign-in ");
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: appbarGreen,
          title: Text("Sign in"),
        ),
        backgroundColor:
            widthScreen > 600 ? webBackgroundColor : mobileBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
              color: mobileBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          margin: widthScreen > 600
              ? EdgeInsets.symmetric(vertical: 55, horizontal: widthScreen / 6)
              : null,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.email))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: isVisable ? false : true,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Password : ",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisable = !isVisable;
                                  });
                                },
                                icon: isVisable
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)))),
                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        signIn();
                      },
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(BTNgreen),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Sign in",
                        style: TextStyle(fontSize: 19),
                      ),
              ),
                    const SizedBox(
                      height: 9,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: Text('sign up',
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline))),
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    SizedBox(
                      width: 299,
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 0.6,
                          )),
                          Text(
                            "OR",
                            style: TextStyle(),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 0.6,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 27),
                      child: GestureDetector(
                        onTap: () {
                          // googleSignInProvider.googlelogin();
                        },
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  // color: Colors.purple,
                                  color: Color.fromARGB(255, 200, 67, 79),
                                  width: 1)),
                          child: SvgPicture.asset(
                            "assets/icons/google.svg",
                            color: Color.fromARGB(255, 200, 67, 79),
                            height: 27,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
        ));
  }
}
