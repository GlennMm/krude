
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krude_digital/Views/Forms/FormsValidator.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/repository/CountryRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class IndividualSignUpForm extends StatefulWidget {
  IndividualSignUpForm({Key key}) : super(key: key);

  @override
  _IndividualSignUpFormState createState() => _IndividualSignUpFormState();
}

class _IndividualSignUpFormState extends State<IndividualSignUpForm> {
  // Form fields controllers
  final username = new TextEditingController();
  final fName = new TextEditingController();
  final lName = new TextEditingController();
  final country = new TextEditingController();
  final email = new TextEditingController();
  final password1 = new TextEditingController();
  final password2 = new TextEditingController();

  // essential
  Config config = new Config();

  @override
  Widget build(BuildContext context) {
    // TODO ADD FORM CONTENT HERE
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Fill the form to create Individual Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff213E4A),
              ),
            ),
            TextField(
              controller: username,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person_outline,
                    color: Color(0xff213E4A),
                  ),
                  labelStyle: TextStyle(color: Color(0xff213E4A)),
                  labelText: "Username",
                  helperText: "eg John",
                  helperStyle: TextStyle(color: Colors.black)),
            ),
            TextField(
              controller: fName,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person_outline,
                    color: Color(0xff213E4A),
                  ),
                  labelStyle: TextStyle(color: Color(0xff213E4A)),
                  labelText: "First Name",
                  helperText: "eg John",
                  helperStyle: TextStyle(color: Colors.black)),
            ),
            TextField(
              controller: lName,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person_outline,
                    color: Color(0xff213E4A),
                  ),
                  labelStyle: TextStyle(color: Color(0xff213E4A)),
                  labelText: "Last Name",
                  helperText: "eg Mark",
                  helperStyle: TextStyle(color: Colors.black)),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: StateBuilder(
                  models: [Injector.getAsReactive<CountryRepository>()],
                  // ignore: missing_return
                  builder: (_, model) {
                    var countriesRepository =
                        Injector.getAsReactive<CountryRepository>();

                    switch (model.connectionState) {
                      case ConnectionState.active:
                        return Container(
                          child: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Loading Countries..."),
                            ],
                          ),
                        );
                      case ConnectionState.done:
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
                                  country.text ?? "Select country",
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
                                    country.text = mCountry.countryName;
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
                      case ConnectionState.none:
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
                                  country.text ?? "Select country",
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
                                    country.text = mCountry.countryName;
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
                      case ConnectionState.waiting:
                        return Text("Waiting");
                    }
                  }),
            ),
            TextField(
              controller: email,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Color(0xff213E4A),
                  ),
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Color(0xff213E4A)),
                  helperText: "eg johnmark@example.com",
                  helperStyle: TextStyle(color: Colors.black)),
            ),
            TextField(
              controller: password1,
              cursorColor: Colors.blue,
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff213E4A),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Color(0xff213E4A)),
                  helperText: "eg something super secret",
                  helperStyle: TextStyle(color: Colors.black)),
            ),
            TextField(
              controller: password2,
              cursorColor: Colors.blue,
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(color: Color(0xff213E4A)),
                  helperText: "eg something super secret",
                  helperStyle: TextStyle(color: Colors.black)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 20),
              child: RaisedButton.icon(
                  elevation: 5,
                  onPressed: () async {
                    bool found = false;
                    var validation = formValidator(username, fName, lName,
                        email, country, password1, password2);
                    int cID;
                    var model = Injector.getAsReactive<CountryRepository>();
                    // model.state.countries.forEach((Country f) {
                    //   if (country.text == f.countryName) {
                    //     cID = f.countryID;
                    //     return found = true;
                    //   }
                    //   return found = false;
                    // });

                    // if (found) {
                    //   return showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //           content: Text("Country not found"));
                    //     },
                    //   );
                    // } else

                    var c = model.state.countries
                        .firstWhere((i) => i.countryName == country.text);

                    if (validation == null) {
                      FormData signupForm = new FormData();
                      signupForm.add("password", password1.text);
                      signupForm.add("countryID", c.countryID);
                      signupForm.add("uname", username.text);
                      signupForm.add("lname", lName.text);
                      signupForm.add("fname", fName.text);
                      signupForm.add("email", email.text);

                      var authVar = Injector.getAsReactive<LoggedInUserRepository>();
                      var result = await authVar.state.signUpIndividual(signupForm);
                      if (result != null) {
                        print(result);
                      }
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
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
