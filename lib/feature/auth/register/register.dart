import 'package:event_app/UI_Utiles/Ui_Utiles.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/resource/regex_manager/regex_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_button.dart';
import 'package:event_app/core/widgets/custom_text_field.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool securePassword = true;
  bool secureRePassword = true;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  late TextEditingController _rePasswordController;

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
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(appLocalizations.register)),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  ImageAssets.eventLogo,
                  width: 130.w,
                  height: 130.h,
                ),
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _nameController,
                validator: ValidatorManager.validateName,
                prefixIcon: Icons.person,
                label: appLocalizations.name,
                keyboardType: TextInputType.name,
              ),

              SizedBox(height: 16.h),

              CustomTextField(
                controller: _emailController,
                label: appLocalizations.email,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: ValidatorManager.validateEmail,
              ),
              SizedBox(height: 16.h),

              CustomTextField(
                controller: _passwordController,
                validator: (value) => ValidatorManager.validatePassword(value),
                isSecure: securePassword,
                prefixIcon: Icons.lock,
                label: appLocalizations.password,
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

              SizedBox(height: 16.h),

              CustomTextField(
                controller: _rePasswordController,
                validator: (value) => ValidatorManager.validateRePassword(
                  value,
                  _passwordController.text,
                ),
                isSecure: secureRePassword,
                prefixIcon: Icons.lock,
                label: appLocalizations.re_password,
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
              SizedBox(height: 16.h),
              CustomButton(
                title: appLocalizations.create_account,
                onPress: _createAccount,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.already_have_account,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomTextButton(
                      text: appLocalizations.login,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteManager.login,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createAccount() async {
    if (_fromKey.currentState?.validate() == false) return;
    try {
      UIUtils.showLoading(context);
      final UserCredential userCredential = await FirebaseServices.register(
        _emailController.text,
        _passwordController.text,
      );
      await FirebaseServices.addUserToFireStore(UserModel(id: userCredential.user!.uid, name: _nameController.text, email: _emailController.text ,favouriteEventsIds: []));
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("The Register Was Successfully", Colors.green);
      Navigator.pushReplacementNamed(context, RouteManager.login);
    } on FirebaseAuthException catch (e) {
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage(e.code, Colors.red);
    } catch (e) {
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Failed to Register", Colors.red);
    }
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
