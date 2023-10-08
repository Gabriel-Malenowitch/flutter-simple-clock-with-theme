import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_clock_with_theme/app_store.dart';
import 'package:simple_clock_with_theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Clock();
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => ClockViewState();
}

class ClockViewState extends State<ClockView> {
  String formattedDate =
      DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        formattedDate =
            DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedDate,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
    );
  }
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    // Se eu quisesse criar um componente a parte usaria:
    // final AppStore appStore = Provider.of<AppStore>(context);

    return ChangeNotifierProvider(
      create: (context) => AppStore(),
      child: Consumer<AppStore>(builder: (context, value, child) {
        return MaterialApp(
          title: 'Clock',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value.themeMode,
          home: Scaffold(
              appBar: AppBar(title: const Text("Keep it simple")),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(children: [
                    const Center(
                      child: ClockView(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: RadioListTile<ThemeMode>(
                              title: const Text("System"),
                              value: ThemeMode.system,
                              groupValue: value.themeMode,
                              onChanged: value.handleToggleTheme),
                        ),
                        SizedBox(
                          width: 150,
                          child: RadioListTile<ThemeMode>(
                              title: const Text("Light"),
                              value: ThemeMode.light,
                              groupValue: value.themeMode,
                              onChanged: value.handleToggleTheme),
                        ),
                        SizedBox(
                          width: 150,
                          child: RadioListTile<ThemeMode>(
                              title: const Text("Dark"),
                              value: ThemeMode.dark,
                              groupValue: value.themeMode,
                              onChanged: value.handleToggleTheme),
                        ),
                      ],
                    )
                  ]),
                ),
              )),
        );
      }),
    );
  }
}
