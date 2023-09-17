import 'package:flutter/material.dart';
import 'dart:async';

class CountDown extends StatefulWidget {
  const CountDown({super.key});
  @override
  State<CountDown> createState() => CountdownTimer();
}

class CountdownTimer extends State<CountDown> {
  final _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? seconds = 0;
  late Timer timer;
  bool isTicking = true;

  void _onTick(Timer time) {
    if(seconds!=0)
      setState(() {
        seconds==-1;
      });
  }

  void _startTimer(){
    seconds=(int.tryParse(_timeController.text)??0);
    Timer.periodic(Duration(seconds:1), _onTick);
    setState(() {
      isTicking = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: Column(
          children: <Widget>[
            _input(context),
            _timerDisplay(context)
          ],
        )
    );
  }

  Widget _input(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              validator: (text) {
                if (text!.isEmpty){
                  return 'Enter a number!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _startTimer,
                child: Text('Start')
            )
          ],
        ),
      ),
    );
  }

  Widget _timerDisplay(BuildContext context){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seconds',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
