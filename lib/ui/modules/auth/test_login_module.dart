// import 'package:flutter/material.dart';
// const login_module = Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: _height,
//                       alignment: Alignment.bottomCenter,
//                       margin: EdgeInsets.symmetric(
//                           horizontal: size.width * (1 / 15)),
//                       child: ListView(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 24),
//                                   child: AppTextField(
//                                     controller: _userNameController,
//                                     hintText: 'User name or Email',
//                                     isObscure: false,
//                                     inputType: TextInputType.text,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 24),
//                                   child: AppTextField(
//                                     controller: _pwdController,
//                                     hintText: 'Password',
//                                     isObscure: true,
//                                     inputType: TextInputType.text,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 12),
//                                     child: RaisedButton(
//                                       color: Colors.white,
//                                       onPressed: onLoginClick,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(90))),
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         padding:
//                                             EdgeInsets.symmetric(vertical: 18),
//                                         width: double.infinity,
//                                         child: Text(
//                                           'Login',
//                                           style: TextStyle(
//                                               fontSize: 18, fontFamily: 'Gotu'),
//                                         ),
//                                       ),
//                                     )),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Fogot password?",
//                                     style: TextStyle(
//                                         fontFamily: 'Gotu',
//                                         fontSize: 16,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 12,
//                     color: Colors.white,
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: _height,
//                       alignment: Alignment.bottomCenter,
//                       margin: EdgeInsets.symmetric(
//                           horizontal: size.width * (1 / 15)),
//                       child: ListView(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 24),
//                                   child: Text(
//                                     'Login with',
//                                     style: TextStyle(
//                                         fontFamily: 'Gotu',
//                                         fontSize: 20,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 24),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 1,
//                                         child: RaisedButton(
//                                           onPressed: () {},
//                                           // child: Image.asset("images/google.png")
//                                           child: Icon(Icons.golf_course),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Container(),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: RaisedButton(
//                                           onPressed: () {},
//                                           // child: Image.asset("images/facebook.png")
//                                           child: Icon(Icons.golf_course),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Text(
//                                   'OR Register your account',
//                                   style: TextStyle(
//                                       fontFamily: 'Gotu',
//                                       color: Colors.white,
//                                       fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               child: RaisedButton(
//                                 color: Colors.white,
//                                 onPressed: () {
//                                   Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) => RegisterPage(),
//                                   ));
//                                 },
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(90))),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   padding: EdgeInsets.symmetric(vertical: 18),
//                                   width: double.infinity,
//                                   child: Text(
//                                     'Register',
//                                     style: TextStyle(
//                                       fontFamily: 'Gotu',
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               );