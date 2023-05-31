import 'package:flutter/material.dart';

const Color _containerDark = Color.fromRGBO(38, 38, 38, 1.0);
const Color _containerLight = Color.fromRGBO(246, 246, 246, 1.0);

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  _CreateDialogState createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog>
    with SingleTickerProviderStateMixin {
  //*-----определяем Animation и AnimationController-----*
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<Offset> _myAnimation;

  //*-----запускаем Animation и AnimationController-----*
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1400),
    );
    _myAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //-disposing the animation controller-
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Animations"),
        ),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: TextField(autofocus: true),
        ),
      );
}
