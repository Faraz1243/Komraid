import 'package:flutter/material.dart';
import 'package:myapp/Crud/UserDL.dart';
import 'package:myapp/RouteGenerator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(),
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color.fromARGB(255, 0, 149, 135),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: ()
                                    {
                                      UserDL.Login(emailController.text,
                                          passwordController.text).then((value) =>
                                      {
                                        if(value.toString() !="null")
                                        {
                                            UserDL.email = value.toString(),
                                            Navigator.of(context).pushNamed('/Home',
                                            arguments: value.toString())
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Signup');
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color.fromARGB(255, 0, 149, 135),
                                      fontSize: 18),
                                ),
                              ),
                              // TextButton(
                              //     onPressed: () {},
                              //     child: const Text(
                              //       'Forgot Password',
                              //       style: TextStyle(
                              //         decoration: TextDecoration.underline,
                              //         color: Color(0xff4c505b),
                              //         fontSize: 18,
                              //       ),
                              //     )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  //  return login page here
  //   return Container(
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(
  //         image: AssetImage('assets/login.png'),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //     child: Scaffold(
  //       body: Stack(
  //         children: [
  //           Container(),
  //           Container(
  //             padding: const EdgeInsets.only(left: 35, top: 130),
  //             child: const Text(
  //               'Welcome\nBack',
  //               style: TextStyle(color: Colors.white, fontSize: 33),
  //             ),
  //           ),
  //           SingleChildScrollView(
  //             child: Container(
  //               padding: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.5),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     margin: const EdgeInsets.only(left: 35, right: 35),
  //                     child: Column(
  //                       children: [
  //                         TextField(
  //                           style: const TextStyle(color: Colors.grey),
  //                           decoration: InputDecoration(
  //                               fillColor: Colors.grey.shade100,
  //                               filled: true,
  //                               hintText: "Email",
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(10),
  //                               )),
  //                         ),
  //                         const SizedBox(
  //                           height: 30,
  //                         ),
  //                         TextField(
  //                           style: const TextStyle(),
  //                           obscureText: true,
  //                           decoration: InputDecoration(
  //                               fillColor: Colors.grey.shade100,
  //                               filled: true,
  //                               hintText: "Password",
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(10),
  //                               )),
  //                         ),
  //                         const SizedBox(
  //                           height: 40,
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             CircleAvatar(
  //                               radius: 30,
  //                               backgroundColor: const Color.fromRGBO(0, 149, 135, 1),
  //                               child: IconButton(
  //                                   color: Colors.white,
  //                                   onPressed: () {},
  //                                   icon: const Icon(
  //                                     Icons.arrow_forward,
  //                                   )),
  //                             )
  //                           ],
  //                         ),
  //                         const SizedBox(
  //                           height: 40,
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             TextButton(
  //                               onPressed: () {
  //                                 Navigator.of(context).pushNamed('/Signup',);
  //                               },
  //                               style: const ButtonStyle(),
  //                               child: const Text(
  //                                 'Sign Up',
  //                                 textAlign: TextAlign.left,
  //                                 style: TextStyle(
  //                                     decoration: TextDecoration.none,
  //                                     color: Color.fromRGBO(0, 149, 135, 1),
  //                                     fontSize: 18),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     )
  //   );
  }
}
