import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              centerTitle: true,
              title: Text(
                'Уведомления',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            // Just some content big enough to have something to scroll.
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  'Уведомлений нет',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
}
