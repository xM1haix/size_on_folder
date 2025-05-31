import 'package:flutter/material.dart';
import 'package:size_on_folder/models.dart';

class ViewAsList extends StatelessWidget {
  final List<FSE> data;
  final void Function(String path) nav;
  final ScrollController controller;
  const ViewAsList({
    super.key,
    required this.controller,
    required this.data,
    required this.nav,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: data.length,
      itemBuilder: (context, i) {
        final e = data[i];
        return Padding(
          padding: EdgeInsets.all(5),
          child: Tooltip(
            textStyle: TextStyle(color: Colors.white),
            decoration: BoxDecoration(color: Colors.transparent),
            message: e.name,
            child: ListTile(
              leading: Icon(e.icon),
              title: Text(e.name),
              onTap: e is FileEntry ? null : () => nav(e.name),
            ),
          ),
        );
      },
    );
  }
}
