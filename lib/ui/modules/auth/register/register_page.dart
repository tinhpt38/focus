import 'package:flutter/material.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/base_page.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/base/text_field.dart';
import 'package:focus_app/ui/modules/auth/auth_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ResponsivePage {
  TextEditingController fullNameCotller = TextEditingController();
  TextEditingController userNameCotller = TextEditingController();
  TextEditingController emailCotller = TextEditingController();
  TextEditingController passwordCotller = TextEditingController();
  TextEditingController confirmPwdCotller = TextEditingController();
  TextEditingController addressCotller = TextEditingController();
  TextEditingController phoneCotller = TextEditingController();
  TextEditingController websiteCotller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  AuthModel _model;

  onRegisterclick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      User user = User(
          fullName: fullNameCotller.text.trim(),
          userName: userNameCotller.text.trim(),
          password: passwordCotller.text.trim(),
          phone: phoneCotller.text.trim(),
          email: emailCotller.text.trim(),
          website: websiteCotller.text.trim(),
          address: addressCotller.text.trim());
      await _model.register(user);
      if (_model.success) {
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * (1 / 10),
                  padding: EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: Text(_model.errorMessage),
                ),
              );
            });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage<AuthModel>(
      model: AuthModel(),
      builder: (context, model, child) {
        _model = model;
        return Scaffold(
            backgroundColor: AppColor.background,
            body: Stack(
              children: [
                buildUi(context),
                Visibility(
                  visible: model.busy,
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.black12,
                      child: CircularProgressIndicator()),
                )
              ],
            ));
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return buildTablet(context);
  }

  @override
  Widget buildTablet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal:size.width * 1/4),
      child: buildMobile(context)
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    Text require = Text(
      "require",
      style: TextStyle(color: Colors.white, fontFamily: "gotu", fontSize: 12),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        child: Icon(
                          Icons.arrow_back
                        )
                      ),
                    )),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Register account for Homie",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26, color: Colors.white, fontFamily: 'Gotu'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: ListView(
                children: [
                  require,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: AppTextField(
                      controller: fullNameCotller,
                      hintText: 'Full Name',
                      isObscure: false,
                      inputType: TextInputType.text,
                      validator: validateFullName,
                    ),
                  ),
                  require,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: AppTextField(
                        controller: userNameCotller,
                        hintText: 'User Name',
                        isObscure: false,
                        inputType: TextInputType.text,
                        validator: validateUsername),
                  ),
                  require,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: AppTextField(
                      controller: emailCotller,
                      hintText: 'Email',
                      isObscure: false,
                      inputType: TextInputType.text,
                      validator: validateEmail,
                    ),
                  ),
                  require,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: AppTextField(
                      controller: passwordCotller,
                      hintText: 'Password',
                      isObscure: true,
                      inputType: TextInputType.text,
                    ),
                  ),
                  require,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: AppTextField(
                      controller: confirmPwdCotller,
                      hintText: 'Confirm Password',
                      isObscure: true,
                      inputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: AppTextField(
                      controller: addressCotller,
                      hintText: 'Address',
                      isObscure: false,
                      inputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: AppTextField(
                      controller: phoneCotller,
                      hintText: 'Phone',
                      isObscure: false,
                      inputType: TextInputType.text,
                      validator: validatePhone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: AppTextField(
                      controller: websiteCotller,
                      hintText: 'Website',
                      isObscure: false,
                      inputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: onRegisterclick,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          width: double.infinity,
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 18, fontFamily: 'Gotu'),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateFullName(String value) =>
      value.trim().length <= 2 ? 'Fullname must be more than 2 charater' : null;
  String validateUsername(String value) =>
      value.contains(' ') ? 'Username not be have space' : null;
  String validatePhone(String value) {
    Pattern pattern = '[0-9]';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return 'Phone number must be digit';
    } else {
      return null;
    }
  }
}
