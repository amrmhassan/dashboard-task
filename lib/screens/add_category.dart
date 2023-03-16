// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_task/constants/cities.dart';
import 'package:dashboard_task/constants/collections.dart';
import 'package:dashboard_task/constants/colors.dart';
import 'package:dashboard_task/constants/sizes.dart';
import 'package:dashboard_task/constants/styles.dart';
import 'package:dashboard_task/global/widgets/button_wrapper.dart';
import 'package:dashboard_task/global/widgets/custom_text_field.dart';
import 'package:dashboard_task/global/widgets/v_space.dart';
import 'package:dashboard_task/screens/select_city.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController name = TextEditingController();

  String? city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VSpace(factor: 2),
          CustomTextField(
            title: 'Category Name',
            controller: name,
          ),
          VSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWrapper(
                padding: EdgeInsets.symmetric(
                  horizontal: kHPad,
                  vertical: kVPad / 2,
                ),
                backgroundColor: Colors.white,
                border: Border.all(width: 1, color: primaryColor),
                onTap: () async {
                  var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCity(),
                      ));
                  if (res == null) return;
                  setState(() {
                    city = res;
                  });
                },
                child: Text(
                  city ?? 'Select City',
                  style: h3TextStyle.copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
          VSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWrapper(
                padding: EdgeInsets.symmetric(
                  horizontal: kHPad * 2,
                  vertical: kVPad / 2,
                ),
                backgroundColor: primaryColor,
                border: Border.all(width: 1, color: primaryColor),
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection(categoryCollectionName)
                      .add({
                    'name': name.text,
                    'city': city,
                  });

                  if (!mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Category added')));
                  setState(() {
                    name.text = '';
                    city = null;
                  });
                },
                child: Text(
                  'Add Category',
                  style: h3TextStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Add Category'),
        backgroundColor: primaryColor,
      ),
    );
  }
}
