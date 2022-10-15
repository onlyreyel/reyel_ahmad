import 'package:flutter/material.dart';
import 'package:reyel_ahmad/core/constants/services/api_service/custome_http.dart';
import 'package:reyel_ahmad/core/model/blog_news_model.dart';
import 'package:reyel_ahmad/features/login/presntation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Blog_News> blogList = [];


  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await CustomeHttp().fetchBlogData;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView.builder(itemBuilder: (context,index){
            return ListTile();

          }),
        ),
      ),
    );
  }
}
