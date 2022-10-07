import 'dart:developer';

import 'package:cardexam/theme.dart';
import 'package:flutter/material.dart';
import 'dart:io' show FileSystemEntity, Platform;
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:desktop_window/desktop_window.dart';

void main() {
  runApp(const MyApp());

  testWindowFunctions();
}

Future testWindowFunctions() async {
  await DesktopWindow.setWindowSize(const Size(330, 350));
  await DesktopWindow.setMinWindowSize(const Size(300, 300));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return MacosApp(
          title: 'FiDeFi',
          theme: MacosThemeData.light(),
          darkTheme: MacosThemeData.dark(),
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _enableButton = true;
  String? _selectedDirectory;
  List files = List.empty(growable: true);
  List<int> _selectedFiles = List.empty(growable: true);

  Future<void> _openFolderPicker(TextEditingController textController) async {
    files = List.empty(growable: true);
    _selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (_selectedDirectory != null) {
      //files = io.Directory("$_selectedDirectory/").listSync();
      var tmp = io.Directory("$_selectedDirectory/").listSync();
      List<String> extensions = textController.text.split(',');
      if (extensions.isNotEmpty && extensions[0] != "") {
        for (var element in tmp) {
          //Получаю расширение файла
          var extenFile = element.path.split('.');
          for (var ext in extensions) {
            //Проверяю с входным потоком необходимых расширений
            if (extenFile[extenFile.length - 1] == ext) {
              files.add(element);
              break;
            }
          }
        }
      } else {
        files = tmp;
      }
      for (var i = 0; i < files.length; i++) {
        _selectedFiles.add(i);
      }
    }
    setState(() {
      _enableButton = true;
    });
  }

  Future<void> _deleteSelectedFiles() async {
    for (int index in _selectedFiles) {
      files[index].delete();
    }
    _selectedFiles = List.empty(growable: true);
    files = io.Directory("$_selectedDirectory/").listSync();
    setState(() {
      _enableButton = true;
    });
  }

  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MacosTheme.brightnessOf(context) == Brightness.dark
          ? MacosColors.underPageBackgroundColor
          : MacosColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: files.isEmpty
                    ? Center(
                        child: Text(
                          "File list empty",
                          style: new TextStyle(
                            fontWeight: FontWeight.w200,
                            color: MacosTheme.brightnessOf(context) ==
                                    Brightness.dark
                                ? Colors.white38
                                : Colors.black38,
                            fontSize: 30,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: (_selectedFiles.contains(index))
                                ? MacosColors.systemGrayColor.withOpacity(0.2)
                                : Colors.transparent,
                            child: ListTile(
                              onTap: () {
                                print(index);
                                if (_selectedFiles.contains(index)) {
                                  setState(() {
                                    _selectedFiles
                                        .removeWhere((val) => val == index);
                                  });
                                } else {
                                  setState(() {
                                    _selectedFiles.add(index);
                                  });
                                }
                              },
                              onLongPress: () {
                                print(files[index].toString());
                                print(index);
                              },
                              leading: files[index].toString()[0] == "F"
                                  ? Icon(
                                      Icons.file_copy,
                                      color: MacosTheme.brightnessOf(context) ==
                                              Brightness.dark
                                          ? MacosColors.windowFrameColor
                                          : MacosColors.gridColor,
                                    )
                                  : Icon(
                                      Icons.folder,
                                      color: MacosTheme.brightnessOf(context) ==
                                              Brightness.dark
                                          ? MacosColors.windowFrameColor
                                          : MacosColors.gridColor,
                                    ),
                              title: Text(
                                files[index].toString(),
                                style: TextStyle(
                                    color: MacosTheme.brightnessOf(context) ==
                                            Brightness.dark
                                        ? MacosColors.textColor
                                        : MacosColors.textBackgroundColor),
                              ),
                            ),
                          );
                        }),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: MacosTextField(
                    controller: textController,
                    placeholder: 'Type some extension',
                  ),
                ),
                const SizedBox(width: 5),
                PushButton(
                    buttonSize: ButtonSize.small,
                    onPressed: !_enableButton
                        ? null
                        : () async {
                            setState(() => _enableButton = false);
                            _openFolderPicker(textController);
                          },
                    child: const Text("Select folder")),
                const SizedBox(width: 10),
                PushButton(
                    buttonSize: ButtonSize.small,
                    onPressed: !_enableButton || files.isEmpty
                        ? null
                        : () async {
                            _enableButton = false;
                            _deleteSelectedFiles();
                          },
                    child: const Text("Delete")),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
