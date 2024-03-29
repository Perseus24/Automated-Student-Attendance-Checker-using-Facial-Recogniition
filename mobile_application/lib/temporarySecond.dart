
//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'signInPage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main.dart';
import 'thirdPage.dart';
import 'appColors.dart';
import 'deleteTHISHIT.dart';
import 'dart:convert';
import 'widgets/big_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:flutter/services.dart' show rootBundle;






void main(){
  runApp(
    RegisterWindow(),
  );
}

class LogInControllers extends GetxController{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailNotFoundController = TextEditingController();
  final passwordWrongController = TextEditingController();

  RxBool hasEmailError = false.obs;
  RxBool hasPasswordError = false.obs;
  RxBool loading = false.obs;

  RxString emailControllerText = ''.obs;
  RxString passwordControllerText = ''.obs;
  RxString emailNotFoundControllerText = ''.obs;
  RxString passwordWrongControllerText = ''.obs;

  void onInit(){
    super.onInit();
    emailController.addListener(() {
      emailControllerText.value = emailController.text;
    });
    passwordController.addListener(() {
      passwordControllerText.value = passwordController.text;
    });
    emailNotFoundController.addListener(() {
      emailNotFoundControllerText.value = emailNotFoundController.text;
    });
    passwordWrongController.addListener(() {
      passwordWrongControllerText.value = passwordWrongController.text;
    });
  }

  void checkValidInput(){
    hasEmailError.value = emailController.text.isEmpty;
    hasPasswordError.value = passwordController.text.isEmpty;
    emailNotFoundControllerText.value = emailNotFoundController.text;
    passwordWrongControllerText.value = passwordWrongController.text;
    update();
  }
}

class Page1TextControllers extends GetxController{
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final sexController = TextEditingController();
  RxBool hasFirstNameError = false.obs;
  RxBool hasLastNameError = false.obs;
  RxBool hasAnyErrorPage1 = false.obs;
  RxBool errorNotif = false.obs;


  RxString firstNameControllerText = ''.obs;
  RxString lastNameControllerText = ''.obs;
  RxString middleNameControllerText = ''.obs;
  RxString sexNameControllerText = ''.obs;

  @override
  void onInit(){
    super.onInit();
    firstNameController.addListener(() {
      firstNameControllerText.value = firstNameController.text;
    });
    lastNameController.addListener(() {
      lastNameControllerText.value = lastNameController.text;
    });
    middleNameController.addListener(() {
      middleNameControllerText.value = middleNameController.text;
    });
    sexController.addListener(() {
      sexNameControllerText.value = sexController.text;
    });
  }
  void checkValidInput(){
    hasFirstNameError.value = firstNameController.text.isEmpty;
    hasLastNameError.value = lastNameController.text.isEmpty;
    hasAnyErrorPage1.value = hasAnyErrorPage1.value;
    errorNotif.value = errorNotif.value;
    //return hasError;
    update();
  }
}

class Page2TextControllers extends GetxController{
  final blocController = TextEditingController();
  final yearLevelController = TextEditingController();
  final courseController = TextEditingController();
  final sexController = TextEditingController();
  RxBool sexEmpty = false.obs;
  RxBool blocEmpty = false.obs;
  RxBool yearLevelEmpty = false.obs;
  RxBool courseEmpty = false.obs;
  RxBool hasAnyErrorPage2 = false.obs;


  RxString sexControllerText = ''.obs;
  RxString courseControllerText = ''.obs;
  RxString yearLevelControllerText = ''.obs;
  RxString blocControllerText = ''.obs;

  @override
  void onInit(){
    super.onInit();
    sexController.addListener(() {
      sexControllerText.value = sexController.text;
    });
    courseController.addListener(() {
      courseControllerText.value = courseController.text;
    });
    yearLevelController.addListener(() {
      yearLevelControllerText.value = yearLevelController.text;
    });
    blocController.addListener(() {
      blocControllerText.value = blocController.text;
    });

  }
  void updateInputs(){
    sexControllerText.value = sexController.text;
    courseControllerText.value = courseController.text;
    yearLevelControllerText.value = yearLevelController.text;
    blocControllerText.value = blocController.text;

    sexEmpty.value = sexController.text.isEmpty;
    courseEmpty.value = courseController.text.isEmpty;
    blocEmpty.value = blocController.text.isEmpty;
    yearLevelEmpty.value = yearLevelController.text.isEmpty;

    hasAnyErrorPage2.value = hasAnyErrorPage2.value;
    //return hasError;
    update();
  }
}


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logInController = Get.put(LogInControllers());

  Future<User?>signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    }on FirebaseAuthException catch(error){
      print(error.code);
      if(error.code == 'invalid-email'){
        logInController.emailNotFoundController.text = "Invalid email";
      }else if(error.code == 'email-already-in-use'){
        logInController.emailNotFoundController.text = "Email is already in use";

      }
    }
  }

  Future<User?>signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }on FirebaseAuthException catch(error){
      print(error.code);
      if(error.code == 'invalid-email'){
        logInController.emailNotFoundController.text = "Invalid email";
      }else if(error.code == 'wrong-password'){
        logInController.passwordWrongController.text = 'Wrong password';
      }
      else if(error.code == 'user-not-found'){
        logInController.emailNotFoundController.text = 'No user with that email';
      }else{
        logInController.emailNotFoundController.text = '';
      }
    }
    return null;
  }


}


class RegisterWindow extends StatelessWidget{
  const RegisterWindow({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );

  }

}



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key:key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final _controller = PageController();
  String firstNameInput = '';
  RxBool hasAnyError = false.obs;

  final Page1TextControllers page1textController = Page1TextControllers();
  final Page2TextControllers page2textController = Page2TextControllers();
  final LogInControllers page3textController = LogInControllers();
  final AuthService authService = AuthService();
  ShakeConstant shakeConstant = ShakeHorizontalConstant2();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers
    Get.put(page1textController);
    Get.put(page2textController);
    Get.put(page3textController);
  }


  List _items = [];

  Future <void> readJson() async{
    final String response = await rootBundle.loadString('s.json');
    final data = await json.decode(response);
    setState((){
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context){
    //ScreenUtil.init(context, designSize: const Size(375, 677));
    CollectionReference student = FirebaseFirestore.instance.collection('students');
    final controller = Get.find<Page1TextControllers>();
    final controller2 = Get.find<Page2TextControllers>();
    final controller3 = Get.find<LogInControllers>();


    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 55, bottom: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        children: [
                          Container(
                              width: 45.h,
                              height: 45.h,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).push(createRouteBack(0));
                                },
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.zero, // <--add this
                                ),
                                child: Image.asset('images/Back.png'),

                              )
                          ),
                        ]
                    )
                ),
                SizedBox(height: 5.h,),
                Center(
                    child: Container(
                        width: 150.w,
                        height: 80.h,
                        child: Stack(
                            children: [
                              Image.asset(
                                'images/logo.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ]
                        )
                    )
                ),
                SizedBox(height: 20.h),
                Obx(()=>Visibility(
                  visible: !controller.errorNotif.value,
                    child: Column(
                        children: [
                          BigText(text: "Register Now!", size: 22.sp, fontWeight: FontWeight.w700,),
                          SizedBox(height: 10),
                          BigText(text: "Please enter your sign up details.", size: 16.sp,
                              color: Colors.black.withOpacity(0.46000000834465027),
                              fontWeight: FontWeight.w400),
                        ]
                  ),
                )),
                Obx(() =>Visibility(
                  visible: controller.errorNotif.value,
                  child: ShakeWidget(
                    duration: Duration(milliseconds: 10),
                    shakeConstant: shakeConstant,
                    autoPlay: controller.hasAnyErrorPage1.value,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      height: 50.h,
                      width: getDynamicSize.getWidth(context)*0.8,
                      decoration: ShapeDecoration(
                        color: Colors.red.shade50,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 3,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error, color: Colors.red.shade900, size: 30.w,),
                          SizedBox(width: 10.w,),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: getDynamicSize.getWidth(context)*0.6,
                              ),
                              child: BigText(text: "Please complete your register details.", maxLines: 2, fontWeight: FontWeight.w400, size: 14.sp, color:Colors.grey.shade700,)),
                        ],
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 25.h),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: getDynamicSize.getHeight(context)*0.4,
                        child: PageView (
                            controller: _controller,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Page1()
                              ),
                              Page2(),
                              Page3(),
                            ]

                        ),

                      ),
                    ]
                ),
                Container(

                  height: getDynamicSize.getHeight(context)*0.06,

                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.blueColor,
                      dotColor: Colors.blue.shade100,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 20,
                    ),
                  ),


                ),
                SizedBox(height: 10.h),
                Stack(
                    children: [
                      Column(
                          children: [
                            Center(
                              child: Container(
                                  width: 287.w,
                                  height: 47.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF1A43BF),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 3,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),

                                  child: ElevatedButton(
                                      clipBehavior: Clip.antiAlias,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:  Color(0xFF1A43BF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () async {
                                        //await readJson();
                                        //print("hi" + _items.length.toString());
                                        controller.checkValidInput();
                                        controller2.updateInputs();

                                        User? user;
                                        try{
                                          user = await authService.signUpWithEmailAndPassword(controller3.emailControllerText.value, controller3.passwordWrongControllerText.value);
                                        }catch(error){

                                        }finally{

                                        }

                                        if(!controller.hasFirstNameError.value && !controller.hasLastNameError.value && !controller2.sexEmpty.value){




                                          //student.doc(_items[0]['id']).set({'hi': _items[0]['name'], 'there': _items[0]['description']});
                                          student.doc(student.id).set({'first_name': controller.firstNameControllerText.value, 'last_name': controller.lastNameControllerText.value,
                                            'middle_name': controller.middleNameControllerText.value, 'sex': controller2.sexControllerText.value});
                                          //student.add({'first_name': controller.firstNameControllerText.value});
                                          controller.firstNameController.text = '';
                                          controller.hasFirstNameError.value = false;
                                          controller.hasLastNameError.value = false;
                                          controller.errorNotif.value = false;
                                          controller.lastNameController.text = '';
                                          controller2.sexController.text = '';
                                          controller.hasAnyErrorPage1.value = false;
                                          Navigator.of(context).push(createRouteGo(1));
                                        }else{
                                          controller.errorNotif.value = true;
                                          controller.hasAnyErrorPage1.value = true;
                                          controller2.hasAnyErrorPage2.value = true;
                                          Duration duration  = Duration(milliseconds: 300);
                                          Future.delayed(duration, (){
                                            controller2.hasAnyErrorPage2.value = false;
                                            controller.hasAnyErrorPage1.value = false;
                                          });
                                        }
                                      },
                                      child: BigText(text: "Sign Up", color: Colors.white, fontWeight: FontWeight.w700,)
                                  )
                              ),
                            ),

                          ]
                      ),
                    ]
                ),
                SizedBox(height: 10,)
              ]
          )

      ),
    );
  }

}

Route createRouteGo(int num){
  Widget goToPage = MyApp();

  switch(num){
    case 0: goToPage = RegisterWindow();
    break;
    case 1: goToPage = MainHomePage();
    break;
    case 2: goToPage = SignInWindow();
    break;
  }
  return PageRouteBuilder(

    pageBuilder:(context, animation, secondaryAnimation) => goToPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      const begin = Offset(0.0, -1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));

      return SlideTransition(
          position: animation.drive(tween),
          child:child
      );
    },
    transitionDuration: Duration(milliseconds: 500),

  );

}

Route createRouteBack(int num){
  Widget goToPage = MyApp();

  switch(num){
    case 0: goToPage = MyApp();
    break;
  }
  return PageRouteBuilder(

    pageBuilder:(context, animation, secondaryAnimation) => goToPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));

      return SlideTransition(
          position: animation.drive(tween),
          child:child
      );
    },
    transitionDuration: Duration(milliseconds: 500),

  );

}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  final page1controller = Get.put(Page1TextControllers());
  ShakeConstant shakeConstant = ShakeHorizontalConstant2();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Container(
            height: getDynamicSize.getHeight(context)*0.03,
            width: getDynamicSize.getWidth(context)*0.8,
            child: Align(
                alignment: Alignment.topLeft,
                child: BigText(text: 'First name', size: 13.sp, fontWeight: FontWeight.w500,)),
          ),
          Obx(() =>ShakeWidget(
            duration: Duration(milliseconds: 10),
            shakeConstant: shakeConstant,
            autoPlay: page1controller.hasAnyErrorPage1.value,
            child: Container(
              height: getDynamicSize.getHeight(context)*0.1,
              width: getDynamicSize.getWidth(context)*0.8,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: getDynamicSize.getHeight(context)*0.06,
                          width: getDynamicSize.getWidth(context)*0.8,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.8500000238418579),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 3,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                            child: TextFormField(
                              controller: page1controller.firstNameController,
                              cursorColor: AppColors.blueColor,
                              onChanged: (_){
                                page1controller.checkValidInput();
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  page1controller.checkValidInput();
                                  return 'This field is required' ;
                                }
                                page1controller.checkValidInput();
                                return null;
                              },
                              decoration: InputDecoration(
                                errorText: page1controller.hasFirstNameError.value ? 'This field is required' : null,
                                //errorStyle: TextStyle(fontSize: 2),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
          Container(
            height: getDynamicSize.getHeight(context)*0.03,
            width: getDynamicSize.getWidth(context)*0.8,
            child: Align(
                alignment: Alignment.topLeft,
                child: BigText(text: 'Last Name', size: 13.sp, fontWeight: FontWeight.w500,)),
          ),
          Obx (() => ShakeWidget(
            duration: Duration(milliseconds: 10),
            shakeConstant: shakeConstant,
            autoPlay: page1controller.hasAnyErrorPage1.value,
            child: Container(
              height: getDynamicSize.getHeight(context)*0.1,
              width: getDynamicSize.getWidth(context)*0.8,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: getDynamicSize.getHeight(context)*0.06,
                          width: getDynamicSize.getWidth(context)*0.8,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.8500000238418579),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 3,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                            child: TextFormField(
                              controller: page1controller.lastNameController,
                              cursorColor: AppColors.blueColor,

                              onChanged: (_){
                                page1controller.checkValidInput();
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required' ;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorText: page1controller.hasLastNameError.value ? 'This field is required' : null,
                                border: InputBorder.none,
                              ),

                            ),
                          ),
                        ),



                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
          Container(
            height: getDynamicSize.getHeight(context)*0.03,
            width: getDynamicSize.getWidth(context)*0.8,
            child: Align(
                alignment: Alignment.topLeft,
                child: BigText(text: 'Middle Name', size: 13.sp, fontWeight: FontWeight.w500,)),
          ),
          Obx(() =>ShakeWidget(
            duration: Duration(milliseconds: 10),
            shakeConstant: shakeConstant,
            autoPlay: page1controller.hasAnyErrorPage1.value,
            child: Container(
              height: getDynamicSize.getHeight(context)*0.1,
              width: getDynamicSize.getWidth(context)*0.8,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: getDynamicSize.getHeight(context)*0.06,
                          width: getDynamicSize.getWidth(context)*0.8,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.8500000238418579),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 3,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                            child: TextFormField(
                              controller: page1controller.middleNameController,
                              cursorColor: AppColors.blueColor,
                              decoration: InputDecoration(
                                errorText: page1controller.hasLastNameError.value ? null : null,
                                //errorStyle: TextStyle(fontSize: 2),
                                border: InputBorder.none,
                                //labelText: "First name *",

                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),

    );
  }
}


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => Page2State();
}

class Page2State extends State<Page2>{

  final List<String> blocItems = [
    'A',
    'B',
    'C',
  ];

  final List<String> courseItems = [
    'Biology',
    'Chemistry',
    'Computer Science',
    'Information Technology',
    'Meteorology'
  ];

  final List<String> yearLevel = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year'
  ];

  final List<String> sex = [
    'Male',
    'Female',
  ];

  String? selectedSexValue;
  String? selectedCourseValue;
  String? selectedYearLevelValue;
  String? selectedBlocValue;

  final _formKey = GlobalKey<FormState>();
  final page2controller = Get.put(Page2TextControllers());
  final page1controller = Get.put(Page1TextControllers());
  ShakeConstant shakeConstant = ShakeHorizontalConstant2();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Obx(()=>ShakeWidget(
                    duration: Duration(milliseconds: 10),
                    shakeConstant: shakeConstant,
                    autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                    child: Container(
                      width: (getDynamicSize.getWidth(context) - 10)*0.63,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.8500000238418579),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 3,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  )),
                  Positioned(
                    child: Obx(()=>ShakeWidget(
                      duration: Duration(milliseconds: 10),
                      shakeConstant: shakeConstant,
                      autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                      child: Container(
                        padding: EdgeInsets.only(top: 0.h, left: 0.h, right: 0.h),
                        child: DropdownButtonFormField2<String>(
                          value: page2controller.sexController.text.isEmpty ?selectedSexValue: page2controller.sexControllerText.value,
                          isExpanded: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: page2controller.sexEmpty.value ? 'This field is required' : null,

                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value){
                            if (value == null || value.isEmpty) {
                              return 'This field is required' ;
                            }
                            return null;
                          },
                          onSaved: (value){
                            page2controller.sexController.text = value.toString();
                            page2controller.updateInputs();
                          },
                          onChanged: (String? value){
                            page2controller.sexController.text = value.toString();
                            selectedSexValue = value;
                            page2controller.updateInputs();
                          },
                          hint: BigText(text: "Select your sex", fontWeight: FontWeight.w400, size: 14.sp,),
                          items: sex
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ))
                              .toList(),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                    )),
                    ),
                ],
              ),
              SizedBox(height: 5.h),
              Stack(
                children: [
                  Obx(()=>ShakeWidget(
                    duration: Duration(milliseconds: 10),
                    shakeConstant: shakeConstant,
                    autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                    child: Container(
                      width: (getDynamicSize.getWidth(context) - 10)*0.63,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.8500000238418579),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 3,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  )),
                  Positioned(
                    child: Obx(()=>ShakeWidget(
                      duration: Duration(milliseconds: 10),
                      shakeConstant: shakeConstant,
                      autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                      child: Container(
                        padding: EdgeInsets.only(top: 0.h, left: 0.h, right: 0.h),
                        child: DropdownButtonFormField2<String>(
                          value: page2controller.courseController.text.isEmpty ?selectedCourseValue: page2controller.courseControllerText.value,
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: page2controller.courseEmpty.value ? 'This field is required' : null,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value){
                            if (value == null || value.isEmpty) {
                              return 'This field is required' ;
                            }
                            return null;
                          },
                          onChanged: (String? value){
                            page2controller.courseController.text = value.toString();
                            selectedCourseValue = value;
                            page2controller.updateInputs();
                          },
                          hint: BigText(text: "Select your course", fontWeight: FontWeight.w400, size: 14.sp,),
                          items: courseItems
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ))
                              .toList(),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Stack(
                children: [
                  Obx(()=>ShakeWidget(
                    duration: Duration(milliseconds: 10),
                    shakeConstant: shakeConstant,
                    autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                    child: Container(
                      width: (getDynamicSize.getWidth(context) - 10)*0.63,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.8500000238418579),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 3,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  )),
                  Positioned(
                    child: Obx(()=>ShakeWidget(
                      duration: Duration(milliseconds: 10),
                      shakeConstant: shakeConstant,
                      autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                      child: Container(
                        padding: EdgeInsets.only(top: 0.h, left: 0.h, right: 0.h),
                        child: DropdownButtonFormField2<String>(
                          value: page2controller.yearLevelController.text.isEmpty ?selectedYearLevelValue: page2controller.yearLevelControllerText.value,
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: page2controller.yearLevelEmpty.value ? 'This field is required' : null,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value){
                            if (value == null || value.isEmpty) {
                              return 'This field is required' ;
                            }
                            return null;
                          },
                          onChanged: (String? value){
                            page2controller.yearLevelController.text = value.toString();
                            selectedYearLevelValue = value;
                            page2controller.updateInputs();
                          },
                          hint: BigText(text: "Select your year level", fontWeight: FontWeight.w400, size: 14.sp,),
                          items: yearLevel
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ))
                              .toList(),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Stack(
                children: [
                  Obx(()=>ShakeWidget(
                    duration: Duration(milliseconds: 10),
                    shakeConstant: shakeConstant,
                    autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                    child: Container(
                      width: (getDynamicSize.getWidth(context) - 10)*0.63,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.8500000238418579),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 3,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  )),
                  Positioned(
                    child: Obx(()=>ShakeWidget(
                      duration: Duration(milliseconds: 10),
                      shakeConstant: shakeConstant,
                      autoPlay: page1controller.hasAnyErrorPage1.value || page2controller.hasAnyErrorPage2.value,
                      child: Container(
                        padding: EdgeInsets.only(top: 0.h, left: 0.h, right: 0.h),
                        child: DropdownButtonFormField2<String>(
                          value: page2controller.blocController.text.isEmpty ?selectedBlocValue: page2controller.blocControllerText.value,
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText: page2controller.blocEmpty.value ? 'This field is required' : null,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value){
                            if (value == null || value.isEmpty) {
                              return 'This field is required' ;
                            }
                            return null;
                          },
                          onChanged: (String? value){
                            page2controller.blocController.text = value.toString();
                            selectedBlocValue = value;
                            page2controller.updateInputs();
                          },
                          hint: BigText(text: "Select your bloc", fontWeight: FontWeight.w400, size: 14.sp,),
                          items: blocItems
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ))
                              .toList(),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                    )),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {

  final page2controller = Get.put(Page2TextControllers());
  final page1controller = Get.put(Page1TextControllers());
  final page3controller = Get.put(LogInControllers());
  ShakeConstant shakeConstant = ShakeHorizontalConstant2();

  bool temp1 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
              height: getDynamicSize.getHeight(context)*0.03,
              width: getDynamicSize.getWidth(context)*0.8,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: BigText(text: 'Email', size: 13.sp, fontWeight: FontWeight.w500,)),
            ),
            Obx(() =>ShakeWidget(
              duration: Duration(milliseconds: 10),
              shakeConstant: shakeConstant,
              autoPlay: page1controller.hasAnyErrorPage1.value,
              child: Container(
                height: getDynamicSize.getHeight(context)*0.1,
                width: getDynamicSize.getWidth(context)*0.8,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: getDynamicSize.getHeight(context)*0.06,
                            width: getDynamicSize.getWidth(context)*0.8,
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.8500000238418579),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                              child: TextFormField(
                                controller: page3controller.emailController,
                                cursorColor: AppColors.blueColor,
                                onChanged: (_){
                                  page3controller.checkValidInput();
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    page3controller.checkValidInput();
                                    return 'This field is required' ;
                                  }
                                  page3controller.checkValidInput();
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorText: page3controller.emailNotFoundController.text.isEmpty ? null : page3controller.emailNotFoundControllerText.value,
                                  //errorStyle: TextStyle(fontSize: 2),
                                  border: InputBorder.none,
                                  //labelText: "First name *",

                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Container(
              height: getDynamicSize.getHeight(context)*0.03,
              width: getDynamicSize.getWidth(context)*0.8,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: BigText(text: 'Password', size: 13.sp, fontWeight: FontWeight.w500,)),
            ),
            Obx(() =>ShakeWidget(
              duration: Duration(milliseconds: 10),
              shakeConstant: shakeConstant,
              autoPlay: page1controller.hasAnyErrorPage1.value,
              child: Container(
                height: getDynamicSize.getHeight(context)*0.1,
                width: getDynamicSize.getWidth(context)*0.8,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: getDynamicSize.getHeight(context)*0.06,
                            width: getDynamicSize.getWidth(context)*0.8,
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.8500000238418579),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                              child: TextFormField(
                                controller: page3controller.passwordController,
                                cursorColor: AppColors.blueColor,
                                onChanged: (_){
                                  page3controller.checkValidInput();
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    page3controller.checkValidInput();
                                    return 'This field is required' ;
                                  }
                                  page3controller.checkValidInput();
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorText: page3controller.passwordWrongController.text.isEmpty ? null : page3controller.passwordWrongControllerText.value,
                                  //errorStyle: TextStyle(fontSize: 2),
                                  border: InputBorder.none,
                                  //labelText: "First name *",

                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Container(
              width: getDynamicSize.getWidth(context)*0.8,
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: temp1?Colors.green:Colors.grey.shade300, size: 20.w,),
                  SizedBox(width: 10.w,),
                  BigText(text: '6-20 characters', size: 13.sp,)
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              width: getDynamicSize.getWidth(context)*0.8,
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: temp1?Colors.green:Colors.grey.shade300, size: 20.w,),
                  SizedBox(width: 10.w,),
                  BigText(text: 'At least one uppercase letter (A to Z)', size: 13.sp,)
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              width: getDynamicSize.getWidth(context)*0.8,
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: temp1?Colors.green:Colors.grey.shade300, size: 20.w,),
                  SizedBox(width: 10.w,),
                  BigText(text: 'No special characters (:;,/")', size: 13.sp,)
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              width: getDynamicSize.getWidth(context)*0.8,
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: temp1?Colors.green:Colors.grey.shade300, size: 20.w,),
                  SizedBox(width: 10.w,),
                  BigText(text: 'No spaces', size: 13.sp,)
                ],
              ),
            ),

          ]
        )
    );
  }
}




Future<List<Sample>> kk() async {
  // Read the JSON file
  String jsonString = await rootBundle.loadString('images/s.json');

  // Parse the JSON string into a List<dynamic>
  List<dynamic> jsonList = json.decode(jsonString);

  // Convert the list into a List<MyItem>
  List<Sample> itemList = jsonList.map((json) => Sample.fromJson(json)).toList();

  return itemList;
}
