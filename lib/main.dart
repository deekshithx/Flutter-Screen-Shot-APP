import 'dart:io';
import 'dart:ui';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final screenShotKey = GlobalKey();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: screenShotKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                child: Text("Take screen shot"),
                onPressed: () async {
                  final boundary = screenShotKey.currentContext
                      ?.findRenderObject() as RenderRepaintBoundary?;
                  await Future.delayed(const Duration(milliseconds: 20));
                  final screenShotImage = await boundary?.toImage(
                      pixelRatio: MediaQuery.of(context).devicePixelRatio);
                  final byteData = await screenShotImage?.toByteData(
                      format: ImageByteFormat.png);
                  final imageBytes = byteData?.buffer.asUint8List();
                  print(imageBytes.toString());
                  if (imageBytes != null) {
                    final Directory temp = await getTemporaryDirectory();
                    final File imageFile = File('${temp.path}/screenShot.png');
                    imageFile.writeAsBytesSync(imageBytes);
                    await Share.shareFiles(['${temp.path}/screenShot.png']);
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

 AnimatedSwitcher(
                          reverseDuration: const Duration(milliseconds: 0),
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0, 1),
                                    end: const Offset(0, 0))
                                .animate(animation),
                            child: child,
                          ),
                          child: selectedConnector == ''
                              ? ChildOne:ChildTwo))
