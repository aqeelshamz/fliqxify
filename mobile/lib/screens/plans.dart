import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflixclone/screens/add_profile.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:netflixclone/widgets/back_btn.dart';
import 'package:netflixclone/widgets/large_button.dart';

int _selectedPlan = -1;

class Plans extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  Plans(this.fullName, this.email, this.password);

  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  @override
  void initState() {
    setState(() {
      _selectedPlan = -1;
    });
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
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPlan = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(borderRadius * 2),
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
                            color:
                                _selectedPlan == index ? primaryColor : grey1,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(borderRadius * 2),
                        ),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                ),
                                child: Text(
                                  "SILVER",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹ 199",
                            style: TextStyle(
                              color: white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "PER MONTH",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(FeatherIcons.x, color: errorRed),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        "480p Quality Streaming",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    children: [
                                      Icon(FeatherIcons.x, color: errorRed),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        "Contain Ads",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    children: [
                                      Icon(FeatherIcons.check,
                                          color: successGreen),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        "For mobile only",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              _selectedPlan == -1
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: LargeButton(
                        onTap: () {
                          Get.to(()=>const AddProfile());
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
}