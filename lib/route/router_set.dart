import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_widgets/scrollable_widget/custom/custom_scroll_view_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/gridview/grid_view_item_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/gridview/grid_view_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/listview/list_view_item_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/listview/list_view_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/options/option_item_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/options/options_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/pageview/page_view_item_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/pageview/page_view_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/reorderable/reorderable_item_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/reorderable/reorderable_list_view_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/single_child/single_child_item_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/single_child/single_child_scroll_view.dart';
import 'package:scrollable_widgets/scrollable_widget/tabbar/tab_bar_screen.dart';
import 'package:scrollable_widgets/scrollable_widget/tabbar/vertical_scrollable_screen.dart';

import '../main.dart';
import '../scrollable_widget/tabbar/tab_bar_screen2.dart';

class RouterSet {
  static final List<GoRoute> routerList = [
    GoRoute(
      path: '/singlechild',
      name: 'SingleChild',
      pageBuilder: (context, state) => MaterialPage(child: SingleChildScrollViewScreen()),
      routes: [
        GoRoute(
          path: ':index',
          pageBuilder: (context, state) {
            final int index = int.parse(state.params['index']!.toString());
            return MaterialPage(
                child: SingleChildItemScreen(index: index, name: singleChildList[index]));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/list',
      name: 'ListView',
      pageBuilder: (context, state) => MaterialPage(child: ListViewScreen()),
      routes: [
        GoRoute(
          path: ':index',
          pageBuilder: (context, state) {
            final int index = int.parse(state.params['index']!.toString());
            return MaterialPage(child: ListViewItemScreen(index: index, name: listViewList[index]));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/grid',
      name: 'GridView',
      pageBuilder: (context, state) => MaterialPage(child: GridViewScreen()),
      routes: [
        GoRoute(
          path: ':index',
          pageBuilder: (context, state) {
            final int index = int.parse(state.params['index']!.toString());
            return MaterialPage(child: GridViewItemScreen(index: index, name: gridViewList[index]));
          },
        ),
      ],
    ),
    GoRoute(
        path: '/page',
        name: 'PageView',
        pageBuilder: (context, state) => MaterialPage(child: PageViewScreen()),
        routes: [
          GoRoute(
            path: ':index',
            pageBuilder: (context, state) {
              final int index = int.parse(state.params['index']!.toString());
              return MaterialPage(
                  child: PageViewItemScreen(index: index, name: pageViewList[index]));
            },
          ),
        ]),
    GoRoute(
      path: '/reorderable',
      name: 'Reorderable',
      pageBuilder: (context, state) => MaterialPage(child: ReorderableListViewScreen()),
      routes: [
        GoRoute(
          path: (':index'),
          pageBuilder: (context, state) {
            final int index = int.parse(state.params['index']!.toString());
            return MaterialPage(
                child: ReorderableItemScreen(index: index, name: reorderableList[index]));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/custom',
      name: 'Custom',
      pageBuilder: (context, state) => MaterialPage(child: CustomScrollViewScreen()),
    ),
    GoRoute(
        path: '/options',
        name: 'etc Options',
        pageBuilder: (context, state) => MaterialPage(child: OptionsScreen()),
        routes: [
          GoRoute(
            path: ':index',
            pageBuilder: (context, state) {
              final int index = int.parse(state.params['index']!.toString());
              return MaterialPage(child: OptionItemScreen(index: index, name: optionList[index]));
            },
          ),
        ]),
    GoRoute(
      path: '/tabbar',
      name: 'TabBar',
      pageBuilder: (context, state) => MaterialPage(child: TabBarScreen()),
    ),
    GoRoute(
      path: '/tabbar2',
      name: 'TabBar2',
      pageBuilder: (context, state) => MaterialPage(child: TabBarScreen2()),
    ),
    GoRoute(
      path: '/vstabbar',
      name: 'Vertical Scrollable',
      pageBuilder: (context, state) => MaterialPage(child: VerticalScrollableScreen()),
    ),
  ];

  GoRouter get router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
          ),
          ...routerList,
        ],
      );
}
