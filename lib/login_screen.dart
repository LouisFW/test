import 'package:flutter/material.dart';
import 'package:pertemuanempat/stopwatch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final FormKey = GlobalKey<FormState>();

  bool LoggedIn = false;
  late String name;

  void validate(){
    final Form = FormKey.currentState;
    if(!Form!.validate()){
      return;
    }
    final name = nameController.text;
    final email = emailController.text;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => StopWatch(name: name, email: email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
       child: buildLoginForm(),
      ),
    );
  }
  Widget buildSuccess(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check, color: Colors.orangeAccent),
        Text('Hi $name'),
      ],
    );
  }

  Widget buildLoginForm(){
    return Form(
      key: FormKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
              validator:  (text){
                if (text!.isEmpty){
                  return 'Enter Email';
                }
                final regex = RegExp('[^@]+@[^\.]+\..+');
                if(!regex.hasMatch(text)){
                  return 'Enter a valid Email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Runner'),
              validator: (text) => text!.isEmpty ? 'Enter the runner\'s name.' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: validate,
                child: Text('Continue')
            )
          ],
        ),
      ),
    );
  }

}
