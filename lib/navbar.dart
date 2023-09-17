import 'package:flutter/material.dart';
import 'package:pertemuanempat/profil.dart';
import 'dart:async';

class NavBar extends StatefulWidget {
  @override
  NavigationBar createState() => NavigationBar();
}

class NavigationBar extends State<NavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    StopWatch(),
    CountDown(),
    About(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tugas-2'),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'StopWatch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'About',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class StopWatch extends StatefulWidget {
  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  int seconds = 0;
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  void _onTick(Timer time) {
    setState(() {
      milliseconds += 100;
    });
  }

  String _secondsString(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer() {
    timer.cancel();
    setState(() {
      isTicking = false;
    });
  }

  void _resetTimer() {
    setState(() {
      milliseconds = 0;
    });
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      _resetTimer();
    });

    scrollController.animateTo(itemHeight * laps.length,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: buildCounter(context)),
          Expanded(child: _buildLapDisplay())
        ],
      ),
    );
  }

  Widget buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white),
          ),
          Text(
            _secondsString(milliseconds),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 24,
          ),
          buildControls(),
        ],
      ),
    );
  }

  Row buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () => _startTimer(),
          child: Text('Start'),
        ),
        SizedBox(
          width: 24,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () => _stopTimer(),
          child: Text('Stop'),
        ),
        SizedBox(
          width: 24,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () => _lap(),
          child: Text('Lap'),
        ),
      ],
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
        child: ListView.builder(
            controller: scrollController,
            itemExtent: itemHeight,
            itemCount: laps.length,
            itemBuilder: (context, index) {
              final milliseconds = laps[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                title: Text('Lap ${index + 1}'),
                trailing: Text(_secondsString(milliseconds)),
              );
            }));
  }
}

class CountDown extends StatefulWidget {
  const CountDown({super.key});
  @override
  State<CountDown> createState() => CountdownTimer();
}

class CountdownTimer extends State<CountDown> {
  final _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int seconds = 0;
  late Timer timer;
  bool isTicking = true;

  void _notif() {
    if (seconds != 0) {
      setState(() {
        Text('Waktu telah berhenti');
      });
    }
  }

  void _onTick(Timer time) {
    if (seconds != 0) {
      setState(() {
        seconds--;
      });
    } else {
      _notif();
      timer.cancel();
    }
  }

  void _startTimer() {
    seconds = (int.tryParse(_timeController.text) ?? 0);
    Timer.periodic(Duration(seconds: 1), _onTick);
    setState(() {
      isTicking = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            _input(context),
            _timerDisplay(context),
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
                if (text!.isEmpty) {
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

  Widget _timerDisplay(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seconds',
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          )
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('image/ftiuntar.png'),
          Image.asset('image/logo.png'),
          Profil(),
        ],
      ),
    );
  }
}