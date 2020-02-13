import 'package:flutter/material.dart';
import 'package:krude_digital/Views/Forms/CompanyForm.dart';
import 'package:krude_digital/Views/Forms/IndividualForm.dart';
import 'package:krude_digital/Views/Forms/VendorForm.dart';
import 'package:krude_digital/repository/CountryRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff213E4A),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person_outline),
                child: Text(
                  "Individual Account",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                icon: Icon(Icons.business),
                child: Text(
                  "Company Account",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                icon: Icon(Icons.contact_mail),
                child: Text(
                  "Vendor Account",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          title: Text('Create Your Account'),
        ),
        body: TabBarView(
          children: [
            IndividualSignUpForm(),
            CompanySignUpForm(),
            VendorSignUpForm()
          ],
        ),
      )
    );
  }
}
