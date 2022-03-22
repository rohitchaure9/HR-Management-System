import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm(
    this.submitFn, 
    this.isLoading,
    );

  final bool isLoading;
  final void Function(
    String email, 
    String password, 
    String userName, 
    bool isLogin,
    BuildContext ctx,
    )submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = ''; 

  void _trySubmit() {
    
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );

      // Use those values to send our auth request..
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    TextFormField(
                      key: ValueKey('Email'),
                      validator: (value) {
                        if(value.isEmpty || !value.contains('@')){
                          return 'Please enter a valid email address';
                        }
                        else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      onSaved: (value) {
                          _userEmail = value;
                      },
                    ),
                    if(!_isLogin)
                    TextFormField(
                      key: ValueKey('Username'),
                      validator: (value) {
                        if(value.isEmpty || value.length < 4) {
                          return 'Username must be atleast 4 character long';
                        }
                        else{
                          return null;
                        }
                      },
                      onSaved: (value) {
                          _userName = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username'
                      ),
                    ),                    
                    TextFormField(
                        key: ValueKey('Password'),
                        validator: (value) {
                          if(value.isEmpty || value.length < 6) {
                            return 'Password must be atleast 6 character long';
                          }
                          else{
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password'
                        ),
                        onSaved: (value) {
                            _userPassword = value;
                        },
                      ),
                    SizedBox(
                      height: 12,
                    ),
                    if(widget.isLoading) CircularProgressIndicator(),
                    if(!widget.isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                        onPressed: _trySubmit,
                        ),
                    if(!widget.isLoading)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin ? 'Create New Account' : 'I already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}