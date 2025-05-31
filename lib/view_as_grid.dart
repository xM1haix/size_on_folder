import 'package:flutter/material.dart';
import 'package:size_on_folder/models.dart';

class ViewAsGrid extends StatelessWidget {
  final List<FSE> data;
  final ScrollController controller;
  final void Function(String path) nav;
  const ViewAsGrid({
    super.key,
    required this.controller,
    required this.data,
    required this.nav,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
      itemCount: data.length,
      controller: controller,
      itemBuilder: (context, i) {
        final e = data[i];
        return Padding(
          padding: EdgeInsets.all(5),
          child: Tooltip(
            textStyle: TextStyle(color: Colors.white),
            decoration: BoxDecoration(color: Colors.transparent),
            message: e.name,
            child: InkWell(
              onTap: e is FileEntry ? null : () => nav(e.name),
              child: GridTile(
                footer: Text(e.name, textAlign: TextAlign.center),
                child: Icon(e.icon, size: 50),
              ),
            ),
          ),
        );
      },
    );
  }
}
