import 'package:cardexam/dio/internet_service.dart';
import 'package:cardexam/models/notify_model.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    print(
                      (await InternetService.instance.executeRequest(
                        () => InternetService.instance.GetNotify(),
                      ) as List)
                          .cast<NotifyModel>()[0]
                          .text,
                    );
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
              title: Text(
                'Уведомления',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            // Just some content big enough to have something to scroll.
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: InternetService.instance.executeRequest(
                  () => InternetService.instance.GetNotify(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    final notifies =
                        (snapshot.data! as List).cast<NotifyModel>();
                    return ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: notifies.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Text(
                            notifies[index].dateNotify,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            notifies[index].text,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  /// handles others as you did on question
                  else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      );
}
