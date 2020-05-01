import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/base_page.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/base/text_field.dart';
import 'package:focus_app/ui/modules/auth/auth_model.dart';
import 'package:focus_app/ui/modules/auth/register/register_page.dart';
import 'package:focus_app/ui/modules/home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ResponsivePage {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  AuthModel _model;


  @override
  void initState() {
    _userNameController.text = "haihuynhngoc24";
    _pwdController.text = "123244";
    super.initState();
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

  onLoginClick() async {
    await _model.login(
        _userNameController.text.trim(), _pwdController.text.trim());
    if (_model.success) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height *(1/10),
              padding: EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Text(
                _model.errorMessage
              ),
            ),
          );
        }
      );
    }
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return buildTablet(context);
  }

  @override
  Widget buildTablet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height / 1.5;
    return Container(
      alignment: Alignment.center,
      color: AppColor.background,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * (1 / 8)),
            width: double.infinity,
            child: VerticalDivider(
              color: Colors.white,
              width: 2,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  "Welcome to Homie",
                  style: TextStyle(
                      fontSize: 42, color: Colors.white, fontFamily: 'Gotu'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: _height,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * (1 / 15)),
                      child: ListView(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: AppTextField(
                                    controller: _userNameController,
                                    hintText: 'User name or Email',
                                    isObscure: false,
                                    inputType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: AppTextField(
                                    controller: _pwdController,
                                    hintText: 'Password',
                                    isObscure: true,
                                    inputType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: onLoginClick,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90))),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 18),
                                        width: double.infinity,
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 18, fontFamily: 'Gotu'),
                                        ),
                                      ),
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Fogot password?",
                                    style: TextStyle(
                                        fontFamily: 'Gotu',
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 12,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: _height,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * (1 / 15)),
                      child: ListView(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: Text(
                                    'Login with',
                                    style: TextStyle(
                                        fontFamily: 'Gotu',
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          // child: Image.asset("images/google.png")
                                          child: Icon(Icons.golf_course),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          // child: Image.asset("images/facebook.png")
                                          child: Icon(Icons.golf_course),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'OR Register your account',
                                  style: TextStyle(
                                      fontFamily: 'Gotu',
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90))),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  width: double.infinity,
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: 'Gotu',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Get more info about us!",
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontFamily: 'Gotu'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height / 1.5;
    return Container(
      alignment: Alignment.center,
      color: AppColor.background,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * (1 / 8)),
            width: double.infinity,
            child: VerticalDivider(
              color: Colors.white,
              width: 2,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  "Welcome to Homie",
                  style: TextStyle(
                      fontSize: 42, color: Colors.white, fontFamily: 'Gotu'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: _height,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * (1 / 15)),
                      child: ListView(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: AppTextField(
                                    controller: _userNameController,
                                    hintText: 'User name or Email',
                                    isObscure: false,
                                    inputType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: AppTextField(
                                    controller: _pwdController,
                                    hintText: 'Password',
                                    isObscure: true,
                                    inputType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: onLoginClick,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90))),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 18),
                                        width: double.infinity,
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 18, fontFamily: 'Gotu'),
                                        ),
                                      ),
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Fogot password?",
                                    style: TextStyle(
                                        fontFamily: 'Gotu',
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 12,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: _height,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * (1 / 15)),
                      child: ListView(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListView(
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Login with',
                                    style: TextStyle(
                                        fontFamily: 'Gotu',
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  // child: Image.asset("images/google.png")
                                  child: Icon(Icons.golf_course),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    // child: Image.asset("images/facebook.png")
                                    child: Icon(Icons.golf_course),
                                  ),
                                ),
                                Text(
                                  'OR Register your account',
                                  style: TextStyle(
                                      fontFamily: 'Gotu',
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90))),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  width: double.infinity,
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: 'Gotu',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Get more info about us!",
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontFamily: 'Gotu'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
