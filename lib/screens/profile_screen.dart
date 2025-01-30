import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapshop/services/firebase.dart';

import '../cache/save_user_data.dart';
import '../common_widgets/button.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginResponse? loginData;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final data = await getLoginData();
    setState(() {
      loginData = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ProfilePic(image: loginData?.image ?? ''),
            loginData?.firstName?.toString()==null?Container():
            Text(
              "${loginData?.firstName?.toString()} ${loginData?.lastName?.toString()}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 16.0 * 2),
            Info(
              infoKey: "User Name",
              info: "${loginData?.username?.toString() ?? ''}",
            ),
            Info(
              infoKey: "Gender",
              info: loginData?.gender ?? '',
            ),
            Info(
              infoKey: "Email Address",
              info: loginData?.email ?? '',
            ),
            const SizedBox(height: 100.0),
            Container(
                width: 200,
                child: ConfirmButton(text: "Logout",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            double h = MediaQuery.of(context).size.height;
                            double w = MediaQuery.of(context).size.width;
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              surfaceTintColor: Colors.white,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: w,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Confirm",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Are you sure you want to logout from this application ?",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            width: w / 3.3,
                                            padding:
                                            EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                  Color(0x26000000)
                                                      .withOpacity(
                                                      0.05)),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                textAlign:
                                                TextAlign.center,
                                                style:
                                                GoogleFonts.roboto(
                                                  color:
                                                  Color(0xffa9a8a8),
                                                  fontSize: w / 26,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await AuthService().signout(context: context);

                                          },
                                          child: Container(
                                            width: w / 3.1,
                                            padding:
                                            EdgeInsets.symmetric(
                                                vertical: 13),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5),
                                              gradient: LinearGradient(
                                                begin:
                                                Alignment.topCenter,
                                                end: Alignment
                                                    .bottomCenter,
                                                colors: [
                                                  Colors.red.shade900,
                                                  Colors.red.shade900
                                                ],
                                              ),
                                            ),
                                            child: Text(
                                              "Logout",
                                              textAlign:
                                              TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: w / 26,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: h / 80,
                                  )
                                ],
                              ),
                            );
                          });

                    }))
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
          Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
