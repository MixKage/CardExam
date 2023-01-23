import 'package:cardexam/theme/theme_manager.dart';
import 'package:flutter/material.dart';

const Color _containerDark = Color.fromRGBO(38, 38, 38, 1.0);
const Color _containerLight = Color.fromRGBO(246, 246, 246, 1.0);

class MyModalBottomSheet extends StatefulWidget {
  final BuildContext context;
  final List<Widget> listWidget;
  final Icon icon;

  const MyModalBottomSheet({
    required this.context,
    required this.listWidget,
    required this.icon,
    super.key,
  });

  @override
  State<MyModalBottomSheet> createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                top: MediaQueryData.fromWindow(
                  WidgetsBinding.instance.window,
                ).padding.top,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: ThemeManager.instance.isDark()
                      ? _containerDark
                      : _containerLight,
                  //TODO: придумать как получать цвет из контекста
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 20.0,
                            width: 44.0,
                          ),
                          Container(
                            height: 5,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.grey.withAlpha(70),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 44.0,
                            child: IconButton(
                              splashRadius: 8,
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close,
                                size: 24.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: ListView(
                          shrinkWrap: true,
                          controller: _scrollController,
                          children: widget.listWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        icon: widget.icon,
      );
}
