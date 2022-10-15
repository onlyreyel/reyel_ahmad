import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reyel_ahmad/core/constants/colors.dart';
import 'package:reyel_ahmad/core/constants/fonts.dart';
import 'package:reyel_ahmad/core/constants/services/api_service/custome_http.dart';
import 'package:reyel_ahmad/features/login/widgets.dart';
import 'package:reyel_ahmad/features/show%20data/presentation/pages/components/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState(){
    isLogin();
    super.initState();
  }

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    if (token != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  getLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    var result = await CustomeHttp()
        .loginUser(emailController.text, passwordController.text);

    setState(() {
      isLoading = false;
    });
    var responce = jsonDecode(result);
    if (responce["status"] == 1) {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString("token", responce['data']['token']);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showInToast("Wrong password");
    }

    print("TOKEN: ${responce['data']['token']}");
    print("TokenResponse: ${sharedPreferences.get("token")}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.person,
            color: CustomColor.primaryColor,
          ),
          title: Text("Login Page",
              style:
                  myStyle(22, 0, 0, CustomColor.primaryColor, FontWeight.w800)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  color: CustomColor.primaryColor,
                  onPressed: () {},
                  icon: Icon(Icons.close_rounded)),
            ),
          ],
        ),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            height: MediaQuery.of(context).size.height * 0.60,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xff224957), width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff224957).withOpacity(0.3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign in",
                  style: myStyle(
                      36, 0, 1, CustomColor.primaryColor, FontWeight.w600),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Sign in & Join Our Community",
                  style: myStyle(
                      18, 0, 2, CustomColor.primaryColor, FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          hintStyle: myStyle(
                              16, 0, 0, CustomColor.wColor, FontWeight.w600),
                          hintText: "Login",
                          filled: true,
                          fillColor: CustomColor.primaryColor),
                      style: TextStyle(color: CustomColor.wColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          hintStyle: myStyle(
                              16, 0, 0, CustomColor.wColor, FontWeight.w600),
                          hintText: "Password",
                          filled: true,
                          fillColor: CustomColor.primaryColor),
                      style: TextStyle(color: CustomColor.wColor),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            color: CustomColor.primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        // child: Icon(
                        //   Icons.check_box_rounded,
                        //   size: 30,
                        // ),
                      ),
                      Text(
                        "Remember Me",
                        style: myStyle(16, 0, 0, CustomColor.primaryColor,
                            FontWeight.w700),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Forget Password?",
                        style: myStyle(16, 0, 0, Colors.black, FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: CustomColor.secondryColor),
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: Text(
                        "Login",
                        style: myStyle(18, 0, 1, CustomColor.primaryColor,
                            FontWeight.w700),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
