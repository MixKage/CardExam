import 'package:cardexam/database/locale_data.dart';
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
  late List<NotifyModel> notifies;

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

  // Future refresh() async {
  //       notifies = (InternetService.instance.executeRequest(
  //             () => InternetService.instance.getNotify(),
  //       ) as List).cast<NotifyModel>();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: CustomScrollView(
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
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: InternetService.instance.executeRequest(
                    () => InternetService.instance.getNotify(),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      notifies = (snapshot.data! as List).cast<NotifyModel>();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: notifies.length,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  notifies[index].dateNotify,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  notifies[index].text,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      final String textError = LocaleData.instance.isGuest
                          ? 'В режиме гостя уведомления недоступны'
                          : 'Нет подключения к сети';
                      return Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Icon(
                            Icons.wifi_off,
                            size: 72,
                          ),
                          Text(
                            textError,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    } else {
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
        ),
      );
}
