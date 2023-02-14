import 'package:cardexam/dio/internet_service.dart';
import 'package:cardexam/models/notify_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                        () => InternetService.instance.getNotify(),
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
                  () => InternetService.instance.getNotify(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    final notifies =
                        (snapshot.data! as List).cast<NotifyModel>();
                    return ListView.separated(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: notifies.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Text(
                            notifies[index].dateNotify,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            notifies[index].text,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    );
                  }

                  /// handles others as you did on question
                  else {
                    return Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black87,
                          highlightColor: Colors.white60,
                          child: const Text(
                            'Card\nExam',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
}
