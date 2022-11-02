import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_widgets/route/router_set.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: RouterSet().router,
    ),
  );
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      appBar: AppBar(title: Text('Scrollable Widgets'),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: RouterSet.routerList
              .map((route) => ElevatedButton(
                  onPressed: () => GoRouter.of(context).push(route.path),
                  child: Text(route.name ?? route.path)))
              .toList(),
        ),
      ),
    );
  }
}
