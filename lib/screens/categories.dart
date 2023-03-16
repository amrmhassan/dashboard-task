// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_task/constants/collections.dart';
import 'package:dashboard_task/constants/colors.dart';
import 'package:dashboard_task/global/widgets/v_space.dart';
import 'package:dashboard_task/models/category.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool loading = true;
  List<CategoryModel> cats = [];

  void getData() async {
    var docs = (await FirebaseFirestore.instance
            .collection(categoryCollectionName)
            .get())
        .docs;
    var res = docs
        .map((e) => CategoryModel(name: e['name'], city: e['city']))
        .toList();
    setState(() {
      loading = false;
      cats = res;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: primaryColor,
      ),
      body: loading
          ? Column(
              children: [VSpace(), CircularProgressIndicator()],
            )
          : Column(
              children: [
                VSpace(),
                ...cats.map((e) => ListTile(
                      leading: Text(e.name),
                      trailing: Text(e.city),
                    ))
              ],
            ),
    );
  }
}
