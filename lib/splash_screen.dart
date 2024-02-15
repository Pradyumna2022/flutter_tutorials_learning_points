import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learning_tutorials_day_by_day/api_call_setstate.dart';
import 'package:learning_tutorials_day_by_day/login_api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginApi()));
      final box = GetStorage();
      var tokenValue = box.read('token');
      print('${box.read('token')}THIS IS YOUR TOKEN ON THE SPLASH SCREEN');
      if(tokenValue ==null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginApi()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ApiSetState()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/backgroundImage.png',width: MediaQuery.of(context).size.width*0.7,),
      ),
    );
  }
}
