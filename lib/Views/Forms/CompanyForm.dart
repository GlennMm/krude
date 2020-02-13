import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krude_digital/Views/Forms/FormsValidator.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/repository/CountryRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CompanySignUpForm extends StatefulWidget {
  CompanySignUpForm({Key key}) : super(key: key);

  @override
  _CompanySignUpFormState createState() => _CompanySignUpFormState();
}

class _CompanySignUpFormState extends State<CompanySignUpForm> {
//  COMPANY ACCOUNT TEXT INPUT CONTROLLERS
  final companyName = new TextEditingController();
  final companyUserName = new TextEditingController();
  final companyEmail = new TextEditingController();
  final companyPassword = new TextEditingController();
  final companyConfirmPassword = new TextEditingController();
  final companyTel = new TextEditingController();
  final companyCell = new TextEditingController();
  final companyAddress1 = new TextEditingController();
  final companyAddress2 = new TextEditingController();
  final companyCity = new TextEditingController();
  final companyCountry = new TextEditingController();

  // essential
  Config config = new Config();

  @override
  Widget build(BuildContext context) {
    return StateBuilder(
        models: [Injector.getAsReactive<CountryRepository>()],
        builder: (_, model) {
          var countries = Injector.getAsReactive<CountryRepository>();
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ListView(
                children: <Widget>[
                  Text(
                    "Fill the form to create Company Account",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff213E4A),
                    ),
                  ),
                  TextField(
                    controller: companyUserName,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person_outline,
                          color: Color(0xff213E4A),
                        ),
                        labelStyle: TextStyle(color: Color(0xff213E4A)),
                        labelText: "Username",
                        helperText: "eg @Company",
                        helperStyle: TextStyle(color: Colors.black)),
                  ),
                  TextField(
                    controller: companyName,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.business,
                          color: Color(0xff213E4A),
                        ),
                        labelStyle: TextStyle(color: Color(0xff213E4A)),
                        labelText: "Company Name",
                        helperText: "eg OK",
                        helperStyle: TextStyle(color: Colors.black)),
                  ),
                  TextField(
                    controller: companyEmail,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xff213E4A),
                        ),
                        labelStyle: TextStyle(color: Color(0xff213E4A)),
                        labelText: "Email",
                        helperText: "eg info.company.com",
                        helperStyle: TextStyle(color: Colors.black)),
                  ),
                  Divider(),
                  TextField(
                    controller: companyPassword,
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
                    controller: companyConfirmPassword,
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
                    controller: companyTel,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.call,
                          color: Color(0xff213E4A),
                        ),
                        labelStyle: TextStyle(color: Color(0xff213E4A)),
                        labelText: "Company Tel",
                        helperStyle: TextStyle(color: Colors.black)),
                  ),
                  TextField(
                    controller: companyCell,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone_android,
                          color: Color(0xff213E4A),
                        ),
                        labelStyle: TextStyle(color: Color(0xff213E4A)),
                        labelText: "Company Cell",
                        helperStyle: TextStyle(color: Colors.black)),
                  ),
                  TextField(
                    controller: companyAddress1,
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
                    controller: companyAddress2,
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
                    controller: companyCity,
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
                          companyCountry.text ?? "Select country",
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
                            companyCountry.text = mCountry.countryName;
                          });
                        },
                        items: countriesRepository.state.countries.map((country){
                          print(country.countryName);
                          return DropdownMenuItem<Country>(
                            child: Text(country.countryName),
                            value: country,
                          );
                        }).toList()
                      ),
                  ],
                );
              }),
            ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 20),
                    child: RaisedButton.icon(
                        elevation: 5,
                        onPressed: () async {
                          bool found = false;
                          var validation = companyFormValidator(
                              companyName,
                              companyUserName,
                              companyEmail,
                              companyPassword,
                              companyConfirmPassword,
                              companyTel,
                              companyCell,
                              companyAddress1,
                              companyAddress2,
                              companyCity,
                              companyCountry);
                          int cID;

                          model.state.countries.forEach((Country f) {
                            if (companyCountry.text == f.countryName) {
                              cID = f.countryID;
                              return found = true;
                            }
                            return found = false;
                          });

                          if (found) {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    content: Text("Country not found"));
                              },
                            );
                          } else if (validation == null) {

                            FormData signupForm = new FormData();
                            signupForm.add("compName", companyName.text);
                            signupForm.add("compUsername", companyUserName.text);
                            signupForm.add("compEmail", companyEmail.text);
                            signupForm.add("compPassword", companyPassword.text);
                            signupForm.add("compTel", companyTel.text);
                            signupForm.add("compCell", companyCell.text);
                            signupForm.add("compAddress1", companyAddress1.text);
                            signupForm.add("compAddress2", companyAddress2.text);
                            signupForm.add("compCity", companyCity.text);
                            signupForm.add("compCountryID", cID);

                            var authVar = Injector.getAsReactive<LoggedInUserRepository>();
                            var result = await authVar.state.signUpCompany(signupForm);
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
              )
              // ),
              );
        });
  }
}
