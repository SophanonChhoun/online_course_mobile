import 'package:flutter/material.dart';
import 'package:online_tutorial/repos/auth.dart';
import 'package:online_tutorial/screens/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_tutorial/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Image(image: AssetImage('assets/images/flare_logo.png')),
          ),
          SignInForm(
            onSubmit: (email, password) {
              AuthRepo auth = AuthRepo();
              auth.signIn(email: email, password: password).then((success) {
                if (success) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  print("Invalid credentials");
                }
              });
            },
          )
        ],
      ),
    ));
  }
}

class SignInForm extends StatefulWidget {
  final Function(String, String) onSubmit;

  SignInForm({this.onSubmit});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();

  bool _validateEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @override
  Widget build(BuildContext context) {
    final _inputFieldBorderRadius = BorderRadius.all(Radius.circular(8));

    _inputFieldDecoration({String hintText = ""}) => InputDecoration(
        contentPadding: EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        border: OutlineInputBorder(borderRadius: _inputFieldBorderRadius),
        enabledBorder: OutlineInputBorder(
            borderRadius: _inputFieldBorderRadius,
            borderSide: BorderSide(color: Theme.of(context).hintColor)),
        hintText: hintText);

    final _emailField = TextFormField(
      onSaved: (value) {
        email = value;
      },
      validator: (value) {
        if (!_validateEmail(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      decoration: _inputFieldDecoration(hintText: "Email"),
    );

    final _passwordField = TextFormField(
      onSaved: (value) {
        password = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a password";
        }
        return null;
      },
      decoration: _inputFieldDecoration(hintText: "Password"),
      obscureText: true,
    );

    final _signInButton = ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            this.widget.onSubmit(email, password);
          }
        },
        child: Text("Sign In"));

    final _signUpInvitation = TextButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpView()));
      },
      child: Text("Don't have an account? Sign Up"),
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
      ),
    );

    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              _emailField,
              SizedBox(height: 8),
              _passwordField,
              SizedBox(height: 16),
              _signInButton,
              _signUpInvitation
            ],
          ),
        ));
  }
}
