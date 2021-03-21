import 'package:flutter/material.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/screens/dashboard.dart';
import 'package:todoapp/services/users.dart';

class Login extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final UsersService usersService = UsersService();
  final TextEditingController _emailInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
          child: Container(
              padding: EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: Text(
                        'TODOIT',
                        style: Theme.of(context).textTheme.headline1,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, top: 10, bottom: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'E-mail',
                                    hintStyle: Theme.of(context).textTheme.caption,
                                    border: InputBorder.none),
                                validator: validateEmail,
                                controller: _emailInputController,
                              )))),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, top: 10, bottom: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: Theme.of(context).textTheme.caption,
                                    border: InputBorder.none),
                                obscureText: true,
                                validator: validatePassword,
                              )))),
                  Container(
                      width: double.infinity,
                      height: 70,
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text('LOGIN', style: TextStyle(fontSize: 18.0)),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            User user = await usersService
                                .getUser(_emailInputController.text);
                            if (user != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard(userId: user.id)));
                            }

                            // setState(() {
                            // });
                          }
                        },
                      ))
                ],
              ))),
    );
  }
}

String validateEmail(String email) {
  if (email.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String validatePassword(String pass) {
  if (pass.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}
