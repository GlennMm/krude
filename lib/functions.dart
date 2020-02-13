import 'package:flutter/material.dart';
import 'package:krude_digital/models/Country.dart';

List<DropdownMenuItem<Country>> generateDropdownMenuItemItems(List<Country> countries) {
  List<DropdownMenuItem<Country>> items;
  countries.forEach((Country item) {
    print(item.countryName);
    // items.add(new DropdownMenuItem<Country>(child: Text(item.countryName), value: item));
    // print(i.value.countryName);
  });
  return items;
}