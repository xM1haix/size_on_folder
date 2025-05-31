import 'package:flutter/material.dart';
import 'package:size_on_folder/models.dart';
import 'package:size_on_folder/view_as_grid.dart';
import 'package:size_on_folder/view_as_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _path;
  late Stream<List<FSE>> _stream;
  bool _view = false;
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_path),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _view = !_view;
            }),
            icon: Icon(
              _view ? Icons.format_list_bulleted_rounded : Icons.grid_on,
            ),
          ),
        ],
        leading: _path == "/"
            ? null
            : IconButton(
                onPressed: () {
                  if (_path == "/") return;
                  var t = _path.substring(0, _path.length - 1);
                  _init(t.substring(0, t.lastIndexOf('/') + 1));
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, a) => AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: switch (a.connectionState) {
            ConnectionState.none => Center(child: Text(a.error.toString())),
            ConnectionState.waiting => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            _ =>
              a.data == null
                  ? Center(child: Text("Something went wrong"))
                  : a.data!.isEmpty
                  ? Center(child: Text("Empty"))
                  : Scrollbar(
                      controller: _controller,
                      child: _view
                          ? ViewAsGrid(
                              controller: _controller,
                              data: a.data!,
                              nav: (path) => _init("$_path$path/"),
                            )
                          : ViewAsList(
                              controller: _controller,
                              data: a.data!,
                              nav: (path) => _init("$_path$path/"),
                            ),
                    ),
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init([String path = "/"]) {
    setState(() {
      _path = path;
      _stream = listEntities(_path);
    });
  }
}
