import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:reyel_ahmad/core/constants/url.dart';
import 'package:reyel_ahmad/core/model/blog_news_model.dart';
import 'package:reyel_ahmad/features/login/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomeHttp {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json"
  };



  Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var map = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}"
    };
    print("user token is ${sharedPreferences.getString("token")}");
    return map;
  }



  //login is here
  Future<String> loginUser(String email, String password) async {
    var link = "${baseUrl}/login";
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    var responce =
        await http.post(Uri.parse(link), body: map, headers: defaultHeader);
    if (responce.statusCode == 200) {
      showInToast("Login Successfully");
      return responce.body;
    } else {
      showInToast("Invalid Email Or Password");
      return "Something is wrong";
    }
  }





  // fetch data from api
  Future<List<Blog_News>> fetchBlogData() async {
    List<Blog_News> blogList = [];
    Blog_News blogNews;
    try {
      var link = "${baseUrl}/admin/blog-news";
      var responce =
          await http.get(Uri.parse(link), headers: await getHeaderWithToken());
      var data = jsonDecode(responce.body);
      print(" response body is ${responce.body}");

      if (responce.statusCode == 200) {
        //print("the blog list is ${responce.body}");
        for (var i in data) {
          blogNews = Blog_News.fromJson(i);
          blogList.add(blogNews);
          // print("the blog list is ${blogList}");
        }
        return blogList;
      } else {
        showInToast("Something is wrong here");
      }
      return blogList;
    } catch (e) {
      print("the problem is $e");
      return blogList;
    }
  }



}
