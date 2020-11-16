import 'dart:convert';
import 'dart:io';
import 'package:imagebutton/imagebutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'LoginResponseModel.dart';
import 'main.dart';

//void main()=>runApp(MyApp());
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _usernameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.pink[200], body: RegisterUI());
  }

  Widget RegisterUI() {
    var name = getshare().then((value) => null);
    return Builder(
      builder: (context) => Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/s5.png',
                      height: 200,
                      width: 250,

                      ),
                  Padding(
                    padding: EdgeInsets.only(left: 50, top: 50),
                  ),
                  Material(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          hintText: "پست الکترونیکی",
                          icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.email, color: Colors.grey[500]),
                          )),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Vazir", fontSize: 20),
                      controller: _usernameController,
                    ),
                    elevation: 20,
                    borderRadius: BorderRadius.circular(40),
                    shadowColor: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.green[600],
                      child: InkWell(
                        onTap: () {
                          print(_usernameController.text);
                          if (_usernameController.text.length < 2 ||
                              _usernameController.text.length == '' ||
                              _usernameController.text.isEmpty ||
                              _usernameController.text == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red[800],

                                content: Text(

                              "لطفا ایمیل خود را وارد کنید",
                              style:
                                  TextStyle(fontSize: 20, fontFamily: "Vazir"),
                                  textAlign: TextAlign.center,
                            )));
                          } else {
                            sendRegisterRequest(
                                context: context,
                                username: _usernameController.text);
                            // sendLoginRequest( context: context, username: usernameController.text );
                          }
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "بازکردن ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Vazir",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.red[500],
                        child: InkWell(
                            onTap: () {
                              sendLogOutRequest(context: context);
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "خروج ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Vazir",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  init() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (sh.getString('key_username') != null)
      _usernameController.text = sh.getString('key_username');
  }

  sendLogOutRequest({BuildContext context, String username}) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString("key_username", null);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWidget_main()));
  }
}

Future<String> getshare() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String auth = prefs.getString("key_username");
  print(auth);
  return auth;
}

void sendRegisterRequest(
    {@required String username,
    //@required String password,
    //@required String phone,
    //@required String email,
    @required BuildContext context}) async {
  //var url = "http://welearnacademy.ir/flutter/api/?type=login";
  print("****");
  var email = getshare().then((value) => null);
  print(email);
  print("****");
  var url =
      "http://192.168.1.177:5050/Key/User/Open?username="+username;
  var body = Map<String, dynamic>();
  String deviceId = await PlatformDeviceId.getDeviceId;
print(deviceId);
  // body["phone"]=phone;
  //body["email"]=email;
  //body["deviceId"] = username;
  //body["password"] = password;
  Response response =
      await post(url, headers: {"deviceId": deviceId});
  print("فراخوانی لاگین");
  print(response);

  if (response.statusCode == 200) {
    //successful

    var Loginjson = json.decode(utf8.decode(response.bodyBytes));
    print(Loginjson);
    var model = LoginResponseModel(Loginjson["Status"], Loginjson["Message"]);
    print("%%%%%%%%%%%%%");
    print(Loginjson["Status"]);
    if (model.Status == false) {
      showMySnacBar(context, model.Message);
    } else if (model.Status == true) exit(1);

    /*Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondAnimation) {
              return LoginWidget();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondAnimation,
                Widget child) {
              return ScaleTransition(
                child: child,
                scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: animation, curve: Curves.fastOutSlowIn)),
              );
            }));
      }*/
  } else {
//error
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "Thanks for using snackbar",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  } //successful
}

void showMySnacBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontFamily: "Vazir", fontSize: 15),
    ),
  ));
}
