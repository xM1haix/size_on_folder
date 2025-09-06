import "package:flutter/material.dart";
import "package:size_on_folder/models.dart";

class ViewAsGrid extends StatelessWidget {
  const ViewAsGrid({
    required this.controller,
    required this.data,
    required this.nav,
    super.key,
  });
  final List<FSE> data;
  final ScrollController controller;
  final void Function(String path) nav;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
      itemCount: data.length,
      controller: controller,
      itemBuilder: (context, i) {
        final e = data[i];
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Tooltip(
            textStyle: const TextStyle(color: Colors.white),
            decoration: const BoxDecoration(color: Colors.transparent),
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
