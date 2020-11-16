import 'dart:convert' show json, utf8;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:connectivity/connectivity.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'LoginResponseModel.dart';
import 'Register.dart';
import 'package:http/http.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String login = prefs.getString("key_username");
  print("key_username:" + login.toString());
  runApp(MaterialApp(home: login == null ? LoginWidget_main() : Register()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'کلید ',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.red,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
            color: Colors.white,
          ))),
      home:

          //  _checkUserLoggedIn() //== true
          //  ?
          //LoginWidget()
          //: Register(),
          LoginWidget_main(),
    );
  }

  Future<String> _checkUserLoggedIn() async {
    SharedPreferences prefs =
        SharedPreferences.getInstance() as SharedPreferences;
    var status = prefs.getString('key_username') ?? "empty";
    print(status);
    return status;
  }

/*bool _checkUserLoggedIn2()   {
   return _storageService.getFromShared('isLoggedIn'); //  Just a get method from shared preferences
  }*/
}

/*bool _checkUserLoggedIn2()   {
   return true;
  }*/

class LoginWidget_main extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget_main> {
  SharedPreferences sharedPreferences;

  Future<bool> token() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String user = sharedPreferences.getString("key_username");

    return true;
  }

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (sh.getString('key_username') != null)
      _usernameController.text = sh.getString('key_username');
  }

  @override
  Widget build(BuildContext context) {
    /*bool xcxc;
    token().then((value) {
      xcxc =value ;
     // print(value);
    });
    print("*******++++++++++=*******");
//print(xcxc);
    print("*******++++++++++=*******");

    if(xcxc==true)*/
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

        SingleChildScrollView(

            //  padding: EdgeInsets.only(left: 50, top: 50),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/s5.png', height: 200, width: 250),
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
                      controller: _usernameController,
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
                              if (_usernameController.text.length < 2 ||
                                  _usernameController.text.length == '' ||
                                  _usernameController.text.isEmpty ||
                                  _usernameController.text == null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red[800],
                                    content: Text(
                                      "لطفا ایمیل خود را وارد کنید",
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: "Vazir"),
                                      textAlign: TextAlign.center,
                                    )));
                              } else {
                                sendLoginRequest(
                                    context: context,
                                    username: _usernameController.text);
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
                                  username: _usernameController.text);
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



// constants/strings.dart

Future<void> sendLogOutRequest({BuildContext context, String username}) async {
  SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
  _sharedPrefs.setString("key_username", "empty");

  Navigator.of(context).pushReplacement(PageRouteBuilder(
      transitionDuration: Duration(seconds: 2),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation) {

        return LoginWidget_main();
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


void sendLoginRequest(
    {@required BuildContext context, @required String username}) async {
  var url = "http://192.168.1.177:5050/Key/User/Login?username="+username;


  print(username);
  String deviceId = await PlatformDeviceId.getDeviceId;
//   var body = Map<String, dynamic>();
  //body["deviceId"] =deviceId;

  Response response =
      await post(url, headers: {"deviceId":deviceId});

  print("**********");
  print(deviceId);

  if (response.statusCode == 200) {
    //successful

    var Loginjson = json.decode(utf8.decode(response.bodyBytes));

    var model = LoginResponseModel(Loginjson["Status"], Loginjson["Message"]);
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    print(model.Status);
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&");
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
    if (model.Status == true || model.Status == null) {
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
    } else {
//error
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red[700],
        content: Text(
          "ایمیل شما ثبت شد منتظر تایید مدیریت می باشد",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "Vazir"),
        ),
        duration: Duration(seconds: 2),

      ));
    }
  } else {
//error
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        " شماره دوم مشکل در وزود و داده" + username + deviceId,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.indigoAccent,
    ));
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
