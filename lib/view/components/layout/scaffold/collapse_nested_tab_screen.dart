import 'package:flutter/material.dart';

class CollapseNestedTabScreen extends StatelessWidget {
  const CollapseNestedTabScreen(
      {@required this.scrollController,
      @required this.title,
      @required this.tabContents,
      @required this.tabTitles})
      : assert(tabContents.length == tabTitles.length,
            'tabTitles and tabContents must be the same size');
  final List<Widget> tabContents;
  final List<String> tabTitles;
  final String title;

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
            body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              key: GlobalKey(),
              pinned: true,
              floating: true,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
              title: Text(
                title,
                key: GlobalKey(),
                style: Theme.of(context).textTheme.headline5,
              ),
              bottom: TabBar(
                tabs: tabTitles
                    .map(
                      (title) => Tab(
                        key: GlobalKey(),
                        child: Text(
                          title,
                          key: GlobalKey(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
          body: TabBarView(
            key: GlobalKey(),
            children: tabContents,
          ),
        )),
      );
}
