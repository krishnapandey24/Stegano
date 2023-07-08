import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stegano/utils/colors.dart';
import 'package:stegano/utils/mobile_login_utils.dart';
import 'package:stegano/utils/styles.dart';

import '../network/api_service.dart';
import '../utils/appt.dart';
import '../utils/constants.dart';
import '../utils/web_login_utils.dart';

class CreateAccount extends StatefulWidget {
  final bool? toEncode;

  const CreateAccount({Key? key, required this.toEncode}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool forSignUp = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final FocusNode _emailFocused = FocusNode();
  final FocusNode _passwordFocused = FocusNode();
  final _passwordController = TextEditingController();
  Color _hoverColorForAlterForText1 = Colors.grey.shade400;
  Color _hoverColorForAlterForText2 = Colors.white;
  final API api= API();


  @override
  void initState() {
    super.initState();
    _emailFocused.addListener(() {setState(() {});});
    _passwordFocused.addListener(() {setState(() {});});
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocused.dispose();
    _passwordFocused.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScreenTypeLayout.builder(
          desktop: (BuildContext context) => buildLogin(true),
          mobile: (BuildContext context) => buildLogin(false),
        ),
      ),
    );
  }

  buildLogin(bool isWeb) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? 30 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          buildLogoAndName(),
          const SizedBox(height: 50),
          Text(
            forSignUp ? "Create your account" : "Log in",
            style: TextStyle(
              fontSize: isWeb ? 40 : 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 50),
          Container(
            margin: EdgeInsets.symmetric(horizontal: isWeb ? (width! * 0.35) : 50),
            child: buildCreateAccountForm(isWeb),
          )
        ],
      ),
    );
  }

  Widget buildCreateAccountForm(bool isWeb) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            focusNode: _emailFocused,
            controller: _emailController,
            maxLength: 50,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              labelText: 'Email',
              labelStyle: TextStyle(
                color: (_emailFocused.hasFocus ? kBlue : Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kBlue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty && !Appt.isValidEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          // const SizedBox(height: 16.0),
          TextFormField(
            focusNode: _passwordFocused,
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              labelText: 'Password',
              labelStyle: TextStyle(
                color: (_passwordFocused.hasFocus ? kBlue : Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kBlue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty && !Appt.isValidPassword(value) && forSignUp) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          const SizedBox(height: 30.0),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: kBlue,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String jwtToken;
                  if (forSignUp) {
                    jwtToken=await api.register(email, password);
                  } else {
                    jwtToken= await api.login(email, password);
                  }
                  storeJwtToken(jwtToken, isWeb);
                  _emailController.clear();
                  _passwordController.clear();
                  if(mounted) Navigator.of(context, rootNavigator: true).pushNamed(widget.toEncode!  ? '/encode' : '/decode');
                }
              },
              child: Text(
                forSignUp ? 'Sign up' : 'Login',
                style: navBarTextStyle,
              ),
            ),
          ),
          const SizedBox(height: 40),
          forSignUp
              ? buildTextWithHoverEffect(
                  "Already have an account?", "Login here")
              : buildTextWithHoverEffect("Don't have an account?", "Sign up")
        ],
      ),
    );
  }

  buildTextWithHoverEffect(String text1, String text2) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        _hoverColorForAlterForText1 = kBlue;
        _hoverColorForAlterForText2 = kBlue;
      }),
      onExit: (event) => setState(() {
        _hoverColorForAlterForText1 = Colors.grey.shade400;
        _hoverColorForAlterForText2 = Colors.white;
      }),
      child: GestureDetector(
        onTap: () => setState(() => forSignUp = !forSignUp),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text1,
              style: TextStyle(
                  color: _hoverColorForAlterForText1,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 5),
            Text(
              text2,
              style: TextStyle(
                  color: _hoverColorForAlterForText2,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Row buildLogoAndName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/logo.svg",
          height: 40,
          width: 40,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 20),
        const Text(
          appName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }

  void storeJwtToken(String jwtToken, bool isWeb){
    if(isWeb){
      WebLoginUtils.storeToken(jwtToken);
    }else{
      MobileLoginUtils.storeToken(jwtToken);
    }
  }
}
