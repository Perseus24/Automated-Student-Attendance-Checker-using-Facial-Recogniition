
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
import 'widgets/big_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';





void main(){
  runApp(
    RegisterWindow(),
  );
}

class Page1TextController extends GetxController{
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final sexController = TextEditingController();
  RxBool hasError = false.obs;

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
    hasError.value = firstNameController.text.isEmpty;
    //return hasError;
    update();
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?>signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    }catch (error){
      print(error.toString());
      return null;
    }
  }

  Future<User?>signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }catch(error){
      return null;
    }
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
  bool isChecked = false;

  final Page1TextController page1textController = Page1TextController();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Initialize the controller outside the build method
    Get.put(page1textController);
  }
  @override

  Widget build(BuildContext context){
    //ScreenUtil.init(context, designSize: const Size(375, 677));
    CollectionReference student = FirebaseFirestore.instance.collection('students');
    final controller = Get.find<Page1TextController>();


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
          SizedBox(height: 22.55.h,),
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
              SizedBox(height: 40.h),
              Column(
                children: [
                  BigText(text: "Register Now!", size: 22.sp, fontWeight: FontWeight.w700,),
                  SizedBox(height: 10),
                  BigText(text: "Please enter your sign up details.", size: 16.sp,
                  color: Colors.black.withOpacity(0.46000000834465027),
                  fontWeight: FontWeight.w400),
                ]
              ),
              SizedBox(height: 25.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: getDynamicSize.getHeight(context)*0.3,
                    child: PageView (
                      controller: _controller,
                      children: [
                        Container(
                          alignment: Alignment.center,
                            child: Page1()
                        ),
                        Page2(),
                        //Page3(),
                      ]

                    ),

                  ),
                ]
              ),
            Container(

              height: getDynamicSize.getHeight(context)*0.06,

                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
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
                              controller.checkValidInput();
                              if(!controller.hasError.value){
                                User? user = await authService.signUpWithEmailAndPassword(
                                    controller.firstNameControllerText.value,
                                    controller.lastNameControllerText.value

                                );
                                student.doc(user?.uid).set({'first_name': controller.firstNameControllerText.value});
                                Navigator.of(context).push(createRouteGo(1));
                              }



                            },
                            child: BigText(text: "Sign p", color: Colors.white, fontWeight: FontWeight.w700,)
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
  State<Page1> createState() => Page1State();
}

class Page1State extends State<Page1>{

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  final page1controller = Get.put(Page1TextController());

  @override
  Widget build(BuildContext context){
    return Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            margin: EdgeInsets.only(top:20, bottom: 20),

            child: Center(
              child: Column(
                  children: [
                    Row(
                        children: [
                          Container(
                              width: (getDynamicSize.getWidth(context) - 10)*0.45,
                              height: 60,
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
                              
                              child: Container(
                                  padding: EdgeInsets.only(left: 20, top: 0.0),
                                  child: Obx(() =>TextFormField(
                                    controller: page1controller.firstNameController,
                                    cursorColor: AppColors.blueColor,

                                    onEditingComplete: (){
                                      page1controller.checkValidInput();
                                    },
                                    onTapOutside: (_) {
                                      page1controller.checkValidInput();
                                    },
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorText: page1controller.hasError.value ? 'This field is required' : null,
                                      border: InputBorder.none,
                                      labelText: "First name *",

                                    ),

                                  ))

                              )

                          ),
                          SizedBox(width: 15),
                          Container(
                              width: (getDynamicSize.getWidth(context) - 10)*0.45,
                              height: 60,
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
                              child: Container(
                                  padding: EdgeInsets.only(left: 20, top: 0.0),
                                  child: Obx(() =>TextFormField(
                                    controller: page1controller.lastNameController,
                                    cursorColor: AppColors.blueColor,

                                    onEditingComplete: (){
                                      page1controller.checkValidInput();
                                    },
                                    onTapOutside: (_) {
                                      page1controller.checkValidInput();
                                    },
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorText: page1controller.hasError.value ? 'This field is required' : null,
                                      border: InputBorder.none,
                                      labelText: "Last name *",

                                    ),

                                  ))

                              )

                          ),
                        ]
                    ),
                    SizedBox(height: 20),

                    //SizedBox(height: 10),
                    Row(
                        children: [
                          Container(
                              width: (getDynamicSize.getWidth(context) - 10)*0.45,
                              height: 60,
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
                              child: Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: TextFormField(
                                      cursorColor: AppColors.blueColor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Middle name",

                                      )
                                  )

                              )

                          ),
                          SizedBox(width: 15),
                          Container(
                            width: (getDynamicSize.getWidth(context) - 10)*0.45,
                            height: 60,
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
                            child: Container(
                              child: Center(
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  hint: BigText(text: "Sex", fontWeight: FontWeight.w400, size: 16),
                                  items: genderItems
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select gender.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //Do something when selected item is changed.
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
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
                            ),
                          ),
                        ]
                    ),
                    //SizedBox(height:30),

                  ]
              ),
            ),
          )


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

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: (getDynamicSize.getWidth(context) - 10)*0.63,
              height: 50,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),

                hint: BigText(text: "Select your course", fontWeight: FontWeight.w400, size: 14,),
                items: courseItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
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
            const SizedBox(height: 20),
            Container(
              width: (getDynamicSize.getWidth(context) - 10)*0.63,
              height: 50,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                hint: BigText(text: "Select your year level", fontWeight: FontWeight.w400, size: 14,),
                items: yearLevel
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your year.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
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
            const SizedBox(height: 20),
            Container(
              width: (getDynamicSize.getWidth(context) - 10)*0.63,
              height: 50,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                hint: BigText(text: "Select your bloc", fontWeight: FontWeight.w400, size: 14,),
                items: blocItems
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
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
          ],
        ),
      ),
    ),
  );
}
}
