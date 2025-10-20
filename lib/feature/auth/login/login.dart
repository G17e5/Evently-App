import 'package:event_app/UI_Utiles/Ui_Utiles.dart';
import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/resource/regex_manager/regex_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/core/widgets/custom_text_button.dart';
import 'package:event_app/core/widgets/custom_text_field.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widgets/custom_button.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool securePassword = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 16.h),
              SafeArea(
                child: Image.asset(
                  ImageAssets.eventLogo,
                  width: 130.w,
                  height: 130.h,
                ),
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                label: appLocalizations.email,
                validator: (value) => ValidatorManager.validateEmail(value),
                prefixIcon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                isSecure: securePassword,
                label: appLocalizations.password,
                suffixIcon: IconButton(
                  onPressed: _onPasswordClickedIcon,
                  icon: Icon(
                    securePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                prefixIcon: Icons.lock,
                validator: (value) => ValidatorManager.validatePassword(value),
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CustomTextButton(
                text: appLocalizations.forget_password,
                onTap: () {},
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 16.h),
              CustomButton(title: appLocalizations.login, onPress: _login),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.dont_have_account,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomTextButton(
                      text: appLocalizations.create_account,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteManager.register,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: ColorsManager.blue,
                      indent: 14,
                      endIndent: 14,
                    ),
                  ),
                  Text(
                    appLocalizations.or,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.black,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: ColorsManager.blue,
                      indent: 14,
                      endIndent: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: REdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: ColorsManager.blue, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  await FirebaseServices.signInWithGoogle();

                  if (FirebaseAuth.instance.currentUser != null) {
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(context, RouteManager.mainLayout);
                  }
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageAssets.goggleIcon),
                    SizedBox(width: 2),
                    Text(
                      appLocalizations.login_with_google,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPasswordClickedIcon() {
    setState(() {
      securePassword = !securePassword;
    });
  }

  void _login() async {
    if (_formKey.currentState?.validate() == false) return;
    try {
      UIUtils.showLoading(context);
      UserCredential userCredential = await FirebaseServices.login(_emailController.text, _passwordController.text,);

     UserModel.currentUser = await FirebaseServices.getUserFromFireStoreById(userCredential.user!.uid);

      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Login was Successfully", Colors.green);
      Navigator.pushReplacementNamed(context, RouteManager.mainLayout);
    } on FirebaseAuthException catch (e) {
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Wrong email or Password", Colors.red);
    } catch (e) {
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Failed to login", Colors.red);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
