import 'package:flutter/material.dart';
import 'package:resume_app/utils/size_config.dart';

class TestInfinity extends StatefulWidget {
  const TestInfinity({super.key});

  @override
  State<TestInfinity> createState() => _TestInfinityState();
}

class _TestInfinityState extends State<TestInfinity> {
  final List<String> _contents = [];
  final int loadLength = 30;

  int _lastIndex = 0;

  //1
  Future<void> _getContents() async {
    await Future.delayed(const Duration(seconds: 3));
    for (int i = _lastIndex; i < _lastIndex + loadLength; i++) {
      _contents.add('Item $i');
    }
    _lastIndex += loadLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinity Scroll Sample')),
      body: Center(
        //2
        child: FutureBuilder(
          future: _getContents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //3
            return ListView.separated(
              itemCount: _contents.length,
              separatorBuilder: (BuildContext context, int index) => Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey,
              ),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      _contents[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
