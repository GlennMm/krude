import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krude_digital/LogIn.dart';
import 'package:krude_digital/Views/Forms/FormsValidator.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/functions.dart';
import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/repository/CountryRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class VendorSignUpForm extends StatefulWidget {
  VendorSignUpForm({Key key}) : super(key: key);

  @override
  _VendorSignUpFormState createState() => _VendorSignUpFormState();
}

class _VendorSignUpFormState extends State<VendorSignUpForm> {
  // VENDOR ACCOUNT TEXT INPUT CONTROLLERS
  final vendorName = new TextEditingController();
  final vendorUserName = new TextEditingController();
  final vendorEmail = new TextEditingController();
  final vendorPassword = new TextEditingController();
  final vendorConfirmPassword = new TextEditingController();
  final vendorTel = new TextEditingController();
  final vendorCell = new TextEditingController();
  final vendorAddress1 = new TextEditingController();
  final vendorAddress2 = new TextEditingController();
  final vendorCity = new TextEditingController();
  final vendorCountry = new TextEditingController();

  // essential
  Config config = new Config();

  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      models: [Injector.getAsReactive<CountryRepository>()],
      builder: (_, model) {
        var countries = Injector.getAsReactive<CountryRepository>();
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: ListView(
              children: <Widget>[
                Text(
                  "Fill form to create Vendor Account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff213E4A),
                  ),
                ),
                TextField(
                  controller: vendorUserName,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person_outline,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Username",
                      helperText: "eg @John",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorName,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.business,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Vendor Name",
                      helperText: "eg John",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorEmail,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Email",
                      helperText: "eg vendor@gmail.com",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                Divider(),
                TextField(
                  controller: vendorPassword,
                  obscureText: true,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outline,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Password",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorConfirmPassword,
                  obscureText: true,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outline,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Confirm Password",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorTel,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.call,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Vendor Tel",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorCell,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone_android,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Vendor Cell",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorAddress1,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.home,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Address Line 1",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorAddress2,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.home,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "Address Line 2",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                TextField(
                  controller: vendorCity,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: Color(0xff213E4A),
                      ),
                      labelStyle: TextStyle(color: Color(0xff213E4A)),
                      labelText: "City",
                      helperStyle: TextStyle(color: Colors.black)),
                ),
                Container(
                  child: StateBuilder(
                      models: [Injector.getAsReactive<CountryRepository>()],
                      builder: (_, model) {
                        var countriesRepository =
                            Injector.getAsReactive<CountryRepository>();
                        return Row(
                          children: <Widget>[
                            Icon(
                              Icons.map,
                              color: Color(0xff213E4A),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DropdownButton<Country>(
                                hint: Text(
                                  vendorCountry.text ?? "Select country",
                                  style: TextStyle(
                                    color: Color(0xff213E4A),
                                  ),
                                ),
                                elevation: 16,
                                style: TextStyle(
                                  color: Color(0xff213E4A),
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Color(0xff213E4A),
                                ),
                                onChanged: (Country mCountry) {
                                  setState(() {
                                    vendorCountry.text = mCountry.countryName;
                                  });
                                },
                                items: countriesRepository.state.countries
                                    .map((country) {
                                  print(country.countryName);
                                  return DropdownMenuItem<Country>(
                                    child: Text(country.countryName),
                                    value: country,
                                  );
                                }).toList()),
                          ],
                        );
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: RaisedButton.icon(
                      elevation: 5,
                      onPressed: () async {
                        // bool found = false;
                        var validation = companyFormValidator( vendorName, vendorUserName, vendorEmail, vendorPassword, vendorConfirmPassword, vendorTel, vendorCell, vendorAddress1, vendorAddress2, vendorCity, vendorCountry);
                        int cID;

                        // model.state.countries.forEach((Country f) {
                        //   if (vendorCountry.text == f.countryName) {
                        //     cID = f.countryID;
                        //     return found = true;
                        //   }
                        //   return found = false;
                        // });
                        // if (found == false) {
                        //   return showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertDialog(
                        //           content: Text("Country not found"));
                        //     },
                        //   );
                        // } else
                        if (validation == null) {
                          FormData _signupForm = new FormData();
                          _signupForm.add("venName", vendorName.text);
                          _signupForm.add("venUsername", vendorUserName.text);
                          _signupForm.add("venEmail", vendorEmail.text);
                          _signupForm.add("venPassword", vendorPassword.text);
                          _signupForm.add("venTel", vendorTel.text);
                          _signupForm.add("venCell", vendorCell.text);
                          _signupForm.add("venAddress1", vendorAddress1.text);
                          _signupForm.add("venAddress2", vendorAddress2.text);
                          _signupForm.add("venCity", vendorCity.text);
                          _signupForm.add("venCountryID", cID);

                          var authVar =
                              Injector.getAsReactive<LoggedInUserRepository>();
                          var result =
                              await authVar.state.signUpVendor(_signupForm);
                          print(result);
                        } else {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(content: Text(validation));
                            },
                          );
                        }
                      },
                      icon: Icon(Icons.person_add),
                      label: Text("Create Account")),
                )
              ],
            ));
      },
    );
  }
}
