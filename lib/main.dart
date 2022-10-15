import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reyel_ahmad/features/login/presntation/pages/login_page.dart';
import 'package:reyel_ahmad/features/show%20data/presentation/pages/components/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
        splitScreenMode: true,
        builder: (context , child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  LogInPage(),
        );
        }
    );
  }
}
