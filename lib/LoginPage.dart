import 'dart:convert' show json, utf8;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:connectivity/connectivity.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'LoginResponseModel.dart';
import 'Register.dart';
import 'main.dart';

class LoginWidget extends StatefulWidget {

  @override

  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  SharedPreferences sharedPreferences;

  Future<String> token() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String res=   sharedPreferences.getString("key_username");




  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  var usernameController = TextEditingController();

  init() async{
    SharedPreferences sh = await SharedPreferences.getInstance();
    if(sh.getString('key_username') != null)
      usernameController.text = sh.getString('key_username');
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(

      backgroundColor: Colors.pink[200],
      body: LoginUI(),
    );
   /* else
      return Register();*/
  }

  Widget LoginUI() {

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


                  Padding(
                    padding: EdgeInsets.only(left: 50, top: 50),
                  ),
                  Material(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          hintText: "پست الکترونیکی",
                          icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.perm_identity,
                                color: Colors.grey[500]),
                          )),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Vazir", fontSize: 20),
                      controller: usernameController,
                    ),
                    elevation: 20,
                    borderRadius: BorderRadius.circular(40),
                    shadowColor: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.indigo,
                        child: InkWell(
                            onTap: () {
                              if (usernameController.text.length < 2 ||
                                  usernameController.text.length == '' ||
                                  usernameController.text.isEmpty ||
                                  usernameController.text == null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.red[800],
                                    content: Text(
                                      "لطفا ایمیل خود را وارد کنید",
                                      style:
                                      TextStyle(fontSize: 15, fontFamily: "Vazir"),
                                      textAlign: TextAlign.center,
                                    )));
                              } else {
                                sendLoginRequest(
                                    context: context,
                                    username: usernameController.text);
                              }
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "ورود ",
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
                  SizedBox(
                    height: 30,
                  ),
/*
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.indigo,
                        child: InkWell(
                            onTap: () {

                              sendLogOutRequest(
                                  context: context,
                                  username: usernameController.text);

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
*/

                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.red[900],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future _checkUserLoggedIn()  async {
/*  SharedPreferences _sharedPrefs;
  _sharedPrefs = await SharedPreferences.getInstance();
  bool res=   _sharedPrefs.getBool("key_username");
  print("_____________________________");

  print(res);

if(res==null) res=false;*/
  String data = "xffxg";

}
 Future<String> getDatabasesPath() async {
String path = await "zxfgvxf";
return path;
}

Future<bool> checkConnectToInternet() async {
  var connectResult = await Connectivity().checkConnectivity();
  print('Connect : $connectResult');
  if (connectResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
    return true;
  } else if (connectResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
    return true;
  }
  return false;
}





// constants/strings.dart

Future<void> sendLogOutRequest({BuildContext context, String username}) async {
  SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
  _sharedPrefs.setString("key_username", "empty");

}


void sendLoginRequest(
    {@required BuildContext context, @required String username}) async {
  var url = "http://192.168.1.177:5050/Key/User/Login?username= "+username;


  print(username);
  String deviceId = await PlatformDeviceId.getDeviceId;
  // var body = Map<String, dynamic>();
  //body["deviceId"] =deviceId;

  Response response =
      await post(url, headers: {"deviceId": deviceId});

  print("**********");
  print(username);

  if (response.statusCode == 200) {
    //successful

    var Loginjson = json.decode(utf8.decode(response.bodyBytes));

    var model = LoginResponseModel(Loginjson["Status"], Loginjson["Message"]);

    if (model.Status == false) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "عدم دسترسی به اینترنت",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.indigoAccent,
        ));
      }
    }
    if (model.Status == true) {
      SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
      _sharedPrefs.setString("key_username", username);


      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondAnimation) {

            return Register();
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
    }
  } else {
//error

  } //successful

  void showMySnacBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(fontFamily: "Vazir", fontSize: 15),
      ),
    ));
  }

}
