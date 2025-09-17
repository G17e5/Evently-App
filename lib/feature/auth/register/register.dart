import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/resource/regex_manager/regex_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_button.dart';
import 'package:event_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool securePassword = true;
  bool secureRePassword = true;
 late  TextEditingController _nameController;
  late TextEditingController _emailController ;
  late TextEditingController _passwordController ;
  late TextEditingController _rePasswordController ;
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Register")),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(
          horizontal: 8,
          vertical: MediaQuery.of(context).viewInsets.top,
        ),
        child: Form(
          key: _fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageAssets.eventLogo, width: 130.w, height: 130.h),
              // SizedBox(height: 24.h),
              CustomTextField(
                controller: _nameController,
                validator: ValidatorManager.validateName,
                prefixIcon: Icons.person,
                label: "Name",
                keyboardType: TextInputType.name,
              ),

              SizedBox(height: 8.h),

              CustomTextField(
                controller: _emailController,
                label: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: ValidatorManager.validateEmail,
              ),
              SizedBox(height: 8.h),

              CustomTextField(
                controller: _passwordController,
                validator: (value)=> ValidatorManager.validatePassword(value),
                isSecure: securePassword,
                prefixIcon: Icons.lock,
                label: "Password",
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      securePassword = !securePassword;
                    });
                  },
                  icon: Icon(
                    securePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              CustomTextField(
                controller: _rePasswordController,
                validator: (value) =>
                    ValidatorManager.validateRePassword(value, _passwordController.text),
                isSecure: secureRePassword,
                prefixIcon: Icons.lock,
                label: "Re Password",
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      secureRePassword = !secureRePassword;
                    });
                  },
                  icon: Icon(
                    secureRePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              CustomButton(title: "Create Account", onPress: _createAccount),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have Account ? ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  CustomTextButton(text: "Login", onTap: () {
                    Navigator.pushReplacementNamed(context, RouteManager.login);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createAccount() {
    if (_fromKey.currentState?.validate() == false) return;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }
}
