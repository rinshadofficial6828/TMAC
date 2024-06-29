import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/custom_login_button.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/text_form_decoration.dart';
import 'package:slrapp/extention/string_extention.dart';
import 'package:slrapp/features/auth/view/register.dart';
import 'package:slrapp/features/auth/viewmodel/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<Authviewmodel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInDown(
              duration: Duration(milliseconds: 800),
              child: Image.asset('loginImg.png'.imagePath)),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(child: Text("User Login",style: normalFonts(20, Colors.black,FontWeight.w600),),),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "this field is Required";
                          
                        }
                      },
                      decoration: emailField(hintText: 'Full name', labelText: 'Full name', data: Icons.person)
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      controller: phonenumController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ],
                      validator: (value){
                        if(value!.isEmpty){
                          return "this field is Required";
                          
                        }
                      },
                      decoration: Phonenumberfield(hintText: "Mobile", labelText: "Mobile", data: Icons.phone,)
                    ),
                    SizedBox(height: 16,),
                    customButton(text: "Login", onTap: () { 
                      if(_formKey.currentState!.validate()){
                        
                        loginViewModel.loginUser(mobile: phonenumController.text, name: emailController.text, context: context);
                      }
                     }),
                     SizedBox(height: 16,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have An Account?",style: normalFonts(12, Colors.black,FontWeight.w600),),SizedBox(width: 7,),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                          },
                          child: Text("Register",style: normalFonts(15, Colors.black,FontWeight.w700),)),
                      ],
                     )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}