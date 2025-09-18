import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/resource/regex_manager/regex_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/core/widgets/custom_text_button.dart';
import 'package:event_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.h),
              Image.asset(ImageAssets.eventLogo, width: 130.w, height: 130.h),
              SizedBox(height: 8.h),
              CustomTextField(
                label: "Email",
                validator: (value) => ValidatorManager.validateEmail(value),
                prefixIcon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                isSecure: securePassword,
                label: "Password",
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
              SizedBox(height: 8.h),
              CustomTextButton(
                text: 'Forget Password',
                onTap: () {},
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 8.h),
              CustomButton(title: "Login", onPress: _login),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t Have Account ? ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  CustomTextButton(
                    text: "Create Account",
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteManager.register,
                      );
                    },
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
                    'OR',
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
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageAssets.goggleIcon),
                    SizedBox(width: 2),
                    Text(
                      "Login With Google",
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

  void _login() {
    if (_formKey.currentState?.validate() == false) return;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
