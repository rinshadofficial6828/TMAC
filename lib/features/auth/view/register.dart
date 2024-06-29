import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/custom_login_button.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/text_form_decoration.dart';
import 'package:slrapp/extention/string_extention.dart';
import 'package:slrapp/features/auth/view/addInformation_screen.dart';
import 'package:slrapp/features/auth/view/login_screen.dart';
import 'package:slrapp/features/auth/viewmodel/auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerViewmodel = Provider.of<Authviewmodel>(context);
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
                    Center(child: Text("User Register",style: normalFonts(20, Colors.black,FontWeight.w600),),),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "this field is Required";
                          
                        }
                      },
                      decoration: emailField(hintText: 'Enter Your Fullname', labelText: 'Full name', data: Icons.person)
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      controller: phoneController,
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
                    customButton(text: "Register", onTap: () { 
                     if(_formKey.currentState!.validate()){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddInformationScreen(name: nameController.text, mobile: phoneController.text,)));
                            }
                     }),
                     SizedBox(height: 16,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Have An Account?",style: normalFonts(12, Colors.black,FontWeight.w600),),SizedBox(width: 7,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
builder: (context) => LoginScreen()), (Route route)=>false);
                          },
                          child: Text("Login",style: normalFonts(15, Colors.black,FontWeight.w700),)),
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