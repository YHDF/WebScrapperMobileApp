library globals;
import 'package:flutter/material.dart';
import 'package:pfe_mobile/favorite.dart';
import 'package:pfe_mobile/feed.dart';
import 'package:pfe_mobile/user.dart';
import 'Group.dart';
import 'package:pfe_mobile/Category.dart';
import 'package:pfe_mobile/Group.dart';
import 'package:pfe_mobile/product.dart';
import 'Provider.dart';
class MyGlobals{
  static bool islightmode = true;
  static bool isdarkmode = false;
  static Color lightcolor;
  static Color darkcolor;
  static List<Group> group_list = List<Group>();
  static List<Product> best_products = List<Product>();
  static List<Provider> provider = List<Provider>();
  static List<Category> category = List<Category>();
  static List<Product> most_visited = List<Product>();
  static List<Product> all_products = List<Product>();
  static List<Product> search_result = List<Product>();
  static List<Feed> feeds = List<Feed>();
  static String api_token = ' ';
  static List<Favorite> favourites = List<Favorite>();
  static User current_user = User(name: '',email: '');
  static int favorite_count = 7;
  static int feedback_count = 7;
  static int categorie_length = 2;
  static int provider_length = 4;
  static int price_range_length = 4;
  static String link_start = 'http://192.168.1.2:8000';
  static String temp_api_token;
  //const Color.fromRGBO(236, 111, 102, 1),
  //const Color.fromRGBO(243, 161, 131, 1),
  String toString(){
    return
      """$islightmode
$isdarkmode""";
  }

}