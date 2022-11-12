import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/size_config.dart';

class ResumeEditScreen extends StatefulWidget {
  const ResumeEditScreen({super.key});

  @override
  State<ResumeEditScreen> createState() => _ResumeEditScreenState();
}

class _ResumeEditScreenState extends State<ResumeEditScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.amber,
                height: SizeConfig.blockSizeVertical! * 30,
                width: SizeConfig.blockSizeHorizontal! * 95,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        // color: Colors.amberAccent,
                        height: SizeConfig.blockSizeVertical! * 9,
                        width: SizeConfig.blockSizeVertical! * 9,
                        child: Icon(FontAwesomeIcons.calendar),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a search term',
                ),
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
