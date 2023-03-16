// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dashboard_task/constants/cities.dart';
import 'package:dashboard_task/constants/colors.dart';
import 'package:dashboard_task/constants/sizes.dart';
import 'package:dashboard_task/global/widgets/button_wrapper.dart';
import 'package:dashboard_task/global/widgets/custom_text_field.dart';
import 'package:dashboard_task/global/widgets/v_space.dart';
import 'package:flutter/material.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({super.key});

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  var res = cities();
  List<String> searchRes = [];

  void searchCities(String query) {
    setState(() {
      searchRes = res
          .where((element) => element.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VSpace(factor: 2),
          CustomTextField(
            title: 'search cities...',
            onChange: (v) {
              searchCities(v);
            },
          ),
          VSpace(),
          searchRes.isEmpty
              ? Text('Search results will be here')
              : Expanded(
                  child: ListView(
                    children: searchRes
                        .map(
                          (e) => ButtonWrapper(
                            padding: EdgeInsets.symmetric(
                              horizontal: kHPad,
                              vertical: kVPad,
                            ),
                            onTap: () {
                              Navigator.pop(
                                context,
                                e,
                              );
                            },
                            child: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
      appBar: AppBar(
        title: Text('Select City'),
        backgroundColor: primaryColor,
      ),
    );
  }
}
