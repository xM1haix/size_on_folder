import "package:flutter/material.dart";
import "package:size_on_folder/models.dart";

class ViewAsList extends StatelessWidget {
  const ViewAsList({
    required this.controller,
    required this.data,
    required this.nav,
    super.key,
  });
  final List<FSE> data;
  final void Function(String path) nav;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: data.length,
      itemBuilder: (context, i) {
        final e = data[i];
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Tooltip(
            textStyle: const TextStyle(color: Colors.white),
            decoration: const BoxDecoration(color: Colors.transparent),
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
