import 'package:flutter/material.dart';
import 'package:banner_listtile/banner_listtile.dart';

import '../utils/size_config.dart';
import '../screens/project_edit_dialog.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('プロジェクト一覧')),
      body: _listWidget(context),
    );
  }

  Widget _listWidget(BuildContext context) {
    List itemList = [
      {
        "id": 1,
        "projectno": 1,
        "joinstart": "20220401",
        "joinend": "20230331",
        "position": "PG",
        "projectsummary": "プロジェクトの説明",
      },
      {
        "id": 2,
        "projectno": 2,
        "joinstart": "20220401",
        "joinend": "20230331",
        "position": "PG",
        "projectsummary": "プロジェクトの説明",
      },
    ];
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return Card(
          child: BannerListTile(
            imageContainerShapeZigzagIndex: index,
            backgroundColor: Colors.white,
            showBanner: false,
            bannerPositionRight: false,
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ProjectEditDialog();
                  });
            },
            title: Text(
              // style: TextStyle(fontSize: 20, color: Colors.white),
              itemList[index]["projectsummary"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
