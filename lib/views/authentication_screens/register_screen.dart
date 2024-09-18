import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_store_app/controllers/vendor_controller.dart';
import 'package:vendor_store_app/views/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Vendor_Controller _vendorController = Vendor_Controller();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //uusing the late keyword specifies that currently we are not applying any valu
  late String email;

  late String fullName;

  late String password;

  bool _isLoading = false;

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    await _vendorController
        .signUpVendor(
            context: context,
            email: email,
            fullName: fullName,
            password: password)
        .whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.4,
            image: AssetImage('assets/images/vendor.webp'),
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Create your Account',
                        style: GoogleFonts.archivoBlack(
                          textStyle: const TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'enter your email',
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        // label: Text(
                        //   's',
                        //   style: GoogleFonts.lato(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/email.png',
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Full Name',
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        fullName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email full name ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'enter your full name',
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        // label: Text(
                        //   'Enter Full Name',
                        //   style: GoogleFonts.lato(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/user.jpeg',
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Password',
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'enter your password',
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        // label: Text(
                        //   'Enter Password',
                        //   style: GoogleFonts.lato(
                        //     color: Colors.black,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/password.png',
                            width: 10,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 23),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          signUpUser();
                        } else {
                          print('Validation failed');
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Sign Up '),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account? ',
                          style: GoogleFonts.roboto(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
