import 'dart:convert';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_tutorials_day_by_day/api_call_setstate.dart';

class LoginApi extends StatefulWidget {
  const LoginApi({super.key});

  @override
  State<LoginApi> createState() => _LoginApiState();
}

class _LoginApiState extends State<LoginApi> {
  Map<String,dynamic>? data ;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> getLoginData(String username, String password) async{
    try{

      var response = await http.post(Uri.parse('https://dummyjson.com/auth/login?username=$username&password=$password'),
          body: jsonEncode({
            'username' : username,
            'password' : password
          }),headers: (
              {"Content-type": "application/json"}
          ));
      data = jsonDecode(response.body);
      if(response.statusCode == 200){
        final box = GetStorage();
        box.write('token', '${data!['token']}');
        print('${box.read('token')}THIS IS YOUR TOKEN ON THE Login SCREEN');
        print('good job');
        final snackBar =  SnackBar(
          backgroundColor: Colors.green,
          content:  Text('Successfully Login',style: TextStyle(
              color: Colors.white
          ),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApiSetState()));
      }else if(response.statusCode == 400){
        final snackBar =  SnackBar(
          backgroundColor: Colors.red,
          content:  Text(data!['message'],style: TextStyle(
              color: Colors.white
          ),),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        print('Error of else find');
      }
    }catch(e){
      print(e.toString()+" ERROR FIND BY CATCH ERROR");
    }
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            // ***********  This is images
            Image.asset('assets/loginbgg.png'),
            // ***********  Apply filter on the image
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            // *********** skip button here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: CircleAvatar(
                  radius: 20,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ApiSetState()));
                    },
                    child: Text("Skip",style: TextStyle(
                      fontSize: 10,color: Colors.white,
                    ),),
                  ),
                ),
              ),
            ),
            // *********** Login button
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key:_formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Username : kminchelle and Passowrd : 0lelplR",style: TextStyle(
                        color: Colors.grey,fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 17,),
                      // email field
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Your Email';
                          }
                        },
                        controller: emailController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white,fontSize: 18),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.white70
                          ),
                          hintText: 'Enter Your Mail ',
                          filled: true,
                          fillColor: Colors.black38,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,width: 1
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,width: 1
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,width: 1
                              )
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red,width: 1
                              )
                          )
                        ),
                      ),
                      SizedBox(height: 17,),
                      // password field
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Your Password';
                          }
                        },
                        controller: passwordController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white,fontSize: 18),
                        decoration: InputDecoration(
                            hintStyle: TextStyle( color: Colors.white70),
                            hintText: 'Enter Your Password ',
                            filled: true,
                            fillColor: Colors.black38,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,width: 1
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,width: 1
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green,width: 1
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,width: 1
                                )
                            )
                        ),
                      ),
                      // login button
                      SizedBox(height: 25,),
                      MaterialButton(onPressed: (){
                        if(_formKey.currentState!.validate()){
                           getLoginData(emailController.text.toString(), passwordController.text.toString());
                        }
                      }, child: Text("Login",style: TextStyle(
                        color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                      ),),minWidth: MediaQuery.sizeOf(context).width,height: 57,color: Colors.grey,shape: 
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)
                        ),)
                    ],
                  ),
                ),
              ),
            ),

          ],
        )

      ),
    );
  }
}
