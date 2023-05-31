import 'package:cardexam/pages/bottom_nav_bar.dart';
import 'package:cardexam/widgets/card_widget.dart';
import 'package:cardexam/widgets/create_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({super.key});

  @override
  State<LocalPage> createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  late ScrollController _scrollController;
  late TextEditingController _nameCardController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _nameCardController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameCardController.dispose();
    super.dispose();
  }

  // Future refresh() async {
  //       notifies = (InternetService.instance.executeRequest(
  //             () => InternetService.instance.getNotify(),
  //       ) as List).cast<NotifyModel>();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Provider.of<HideNavBar>(context, listen: false)
                        .hideNavigationBar();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const CreateCardDialog(),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
              title: Text(
                'Локальное',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            // Just some content big enough to have something to scroll.
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: const [
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  Text('2'),
                ],
              ),
            ),
          ],
        ),
      );
}
