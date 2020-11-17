import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_rx_bloc/view/components/common/icon/gradient_icon.dart';
import 'package:provider/provider.dart';

class FloatingBottomAppBarScreen extends StatelessWidget {
  const FloatingBottomAppBarScreen(
      {@required this.pagesBuilder, @required this.pageCount});
  // Note: pageCount must be equal to pagesBuilder(context,controllers).length;

  final List<Widget> Function(BuildContext, List<ScrollController>)
      pagesBuilder;
  final int pageCount;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                _FloatingBottomAppBarScreenViewModel(pageCount: pageCount),
          )
        ],
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(
                Theme.of(context).canvasColor.red - 10,
                Theme.of(context).canvasColor.green - 10,
                Theme.of(context).canvasColor.blue - 10,
                1),
            body: Stack(children: [
              Selector<_FloatingBottomAppBarScreenViewModel, int>(
                  shouldRebuild: (prev, next) => prev != next,
                  selector: (_, viewModel) => viewModel.currentPage,
                  builder: (_, page, __) => Selector<
                          _FloatingBottomAppBarScreenViewModel,
                          List<ScrollController>>(
                        shouldRebuild: (prev, next) => prev != next,
                        selector: (context, viewModel) =>
                            viewModel.pageScrollControllers,
                        builder: (context, scrollControllers, __) =>
                            IndexedStack(
                          children:
                              pagesBuilder(context, scrollControllers).length ==
                                      pageCount
                                  ? pagesBuilder(context, scrollControllers)
                                  : null,
                          index: page,
                        ),
                      )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<_FloatingBottomAppBarScreenViewModel>(
                    builder: (_, viewModel, __) {
                  final currentPage = viewModel.currentPage;

                  return ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Theme.of(context).canvasColor.withOpacity(0.5),
                        child: BottomNavigationBar(
                          backgroundColor: Colors.transparent,
                          type: BottomNavigationBarType.fixed,
                          showUnselectedLabels: true,
                          selectedItemColor: Theme.of(context).primaryColor,
                          unselectedItemColor: Colors.grey,
                          elevation: 0,
                          currentIndex: currentPage,
                          onTap: (pageIdx) {
                            // 現在見ているタブをクリックするとページの一番上までscroll up する処理
                            if (currentPage == pageIdx) {
                              viewModel.pageScrollControllers[currentPage]
                                  .animateTo(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.ease);
                              viewModel.updatePage(pageIdx);
                            }
                          },
                          items: const [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.star_border),
                              activeIcon: GradientIcon(Icons.star_border),
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.bookmark_border),
                              activeIcon: GradientIcon(Icons.bookmark_border),
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.label_outline),
                              activeIcon: GradientIcon(Icons.label_outline),
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.more_horiz),
                              activeIcon: GradientIcon(Icons.more_horiz),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ]),
          ),
        ),
      );
}

class _FloatingBottomAppBarScreenViewModel extends ChangeNotifier {
  _FloatingBottomAppBarScreenViewModel({@required this.pageCount})
      : pageScrollControllers = Iterable<ScrollController>.generate(pageCount)
            .map((idx) => ScrollController())
            .toList();
  final int pageCount;
  int currentPage = 0;
  final List<ScrollController> pageScrollControllers;

  void updatePage(int pageIdx) {
    currentPage = pageIdx;
    notifyListeners();
  }
}
