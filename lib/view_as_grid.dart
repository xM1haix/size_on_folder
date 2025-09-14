import "package:flutter/material.dart";
import "package:size_on_folder/models.dart";

///View the [data] as [GridView]
class ViewAsGrid extends StatelessWidget {
  ///Construction of the [ViewAsGrid]
  const ViewAsGrid({
    required this.controller,
    required this.data,
    required this.nav,
    super.key,
  });

  ///the [List] of [FSE] representing the data in the [GridView]
  final List<FSE> data;

  ///The [ScrollController] of the [GridView]
  final ScrollController controller;

  ///The [Function] to navigate to the new [path]
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
