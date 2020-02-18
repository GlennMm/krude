import 'package:flutter/material.dart';
import 'package:krude_digital/Views/Dashboard.dart';
import 'package:krude_digital/Views/Forms/FormsValidator.dart';
import 'package:krude_digital/global_widgets/Dialogs.dart';
import 'package:krude_digital/repository/ClientProductRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Form fields controllers
  final username = new TextEditingController();
  final password = new TextEditingController();
  var authVar = Injector.getAsReactive<LoggedInUserRepository>();

  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      models: [Injector.getAsReactive<LoggedInUserRepository>()],
      builder: (_, auth) {
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 20.0),
                  margin: EdgeInsets.only(top: 20.0),
                  child: Image.asset("images/logo.png")),
              Container(
                padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: username,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontFamily: 'Monserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        icon: Icon(Icons.person),
                        ke
                      ),

                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      margin: EdgeInsets.all(10.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 50.0,
                          width: 110.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async {
                                var invalid = loginFormValidator(username, password);
                                if (invalid != null) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          elevation: 5,
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.warning,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(invalid)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                                loggingIn(context);

                                await authVar.state.login(
                                  username.text.toString().trim(),
                                  password.text.toString().trim()
                                );
                                if (authVar.state.loggedInUser == null) {
                                  Navigator.pop(context);
                                  return dialog(context, "Failed to login");
                                }
                                setState(() {
                                  username.text = '';
                                  password.text = '';
                                });
                                return Navigator.push( context, MaterialPageRoute(builder: (context) => Dashboard()));
                              },
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 50.0,
                          width: 110.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New to Krude Digital ?',
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
