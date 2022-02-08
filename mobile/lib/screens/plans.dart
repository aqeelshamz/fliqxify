import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/add_profile.dart';
import 'package:netflixclone/screens/home.dart';
import 'package:netflixclone/screens/signin.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';
import 'package:http/http.dart' as http;

int _selectedPlan = -1;
List _plans = [];
bool _loading = true;

class Plans extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const Plans(this.fullName, this.email, this.password, {Key? key})
      : super(key: key);

  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  @override
  void initState() {
    setState(() {
      _selectedPlan = -1;
    });
    getPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(width * 0.04),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const BackBtn(),
                  Text(
                    "Choose your plan",
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _plans.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPlan = _plans[index]["id"];
                              });
                            },
                            borderRadius:
                                BorderRadius.circular(borderRadius * 2),
                            child: Container(
                              padding: EdgeInsets.only(
                                top: height * 0.01,
                                bottom: height * 0.05,
                                left: height * 0.01,
                                right: height * 0.01,
                              ),
                              margin: EdgeInsets.all(width * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedPlan == _plans[index]["id"]
                                      ? primaryColor
                                      : grey1,
                                  width: 3,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius * 2),
                              ),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: width * 0.025),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(
                                          borderRadius,
                                        ),
                                      ),
                                      child: Text(
                                        _plans[index]["name"]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "₹ " + _plans[index]["price"].toString(),
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  _plans[index]["month"].toString(),
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: getFeaturesWidgets(index)),
                                  ],
                                ),
                              ]),
                            ),
                          );
                        },
                      ),
              ),
              _selectedPlan == -1 || _loading
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: LargeButton(
                        onTap: () {
                          register();
                        },
                        label: "CONTINUE TO PAYMENT",
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    setState(() {
      _loading = true;
    });
    Map<String, String> headers = {
      "Content-Type"  : "application/json"
    };

    Map<String, dynamic> body = {
      "name": widget.fullName,
      "email": widget.email,
      "password": widget.password,
      "type": "user",
      "plan": _selectedPlan
    };
    var response = await http.post(
      Uri.parse("$serverURL/users/register"),
      headers: headers,
      body: jsonEncode(body),
    );
    setState(() {
      _loading = false;
    });

    if(response.statusCode == 200){
      Fluttertoast.showToast(msg: "Registration Successful!", backgroundColor: primaryColor);
      Get.offAll(() => const SignIn());
    }
    else if (response.statusCode == 401){
      Fluttertoast.showToast(msg: "Email already used!", backgroundColor: errorRed);
    }
    else{
      Fluttertoast.showToast(msg: "Something went wrong", backgroundColor: errorRed);
    }
  }

  void getPlans() async {
    setState(() {
      _loading = true;
    });
    var response = await http.get(Uri.parse("$serverURL/plans"));
    setState(() {
      _plans = jsonDecode(response.body);
      _loading = false;
    });
  }

  List<Widget> getFeaturesWidgets(int index) {
    List<Widget> widgets = [];
    for (int i = 0; i < _plans[index]["features"].length; i++) {
      widgets.add(
        Row(
          children: [
            Icon(FeatherIcons.check, color: successGreen),
            SizedBox(width: width * 0.02),
            Text(
              _plans[index]["features"][i],
              style: TextStyle(
                color: white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      );
      widgets.add(SizedBox(height: height * 0.02));
    }
    return widgets;
  }

  
}
