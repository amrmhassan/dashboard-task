import 'dart:io';

import 'package:dashboard_task/constants/cities_var.dart';

List<String> cities() {
  List<String> res = [];
  citiesVar.split('\n').forEach((city) {
    String cityLocation = '${city.split(' ').first}, ${city.split(' ').last}';
    res.add(cityLocation);
  });
  return res;
}
