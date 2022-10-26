import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_widgets/screen/custom_scroll_view_screen.dart';
import 'package:scrollable_widgets/screen/grid_view_screen.dart';
import 'package:scrollable_widgets/screen/list_view_screen.dart';
import 'package:scrollable_widgets/screen/refresh_indicator_screen.dart';
import 'package:scrollable_widgets/screen/reorderable_list_view_screen.dart';
import 'package:scrollable_widgets/screen/scrollbar_screen.dart';
import 'package:scrollable_widgets/single_child/single_child_item_screen.dart';
import 'package:scrollable_widgets/single_child/single_child_scroll_view.dart';

import '../main.dart';

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
        )
      ],
    ),
    GoRoute(
      path: '/list',
      name: 'ListView',
      pageBuilder: (context, state) => MaterialPage(child: ListViewScreen()),
    ),
    GoRoute(
      path: '/grid',
      name: 'GridView',
      pageBuilder: (context, state) => MaterialPage(child: GridViewScreen()),
    ),
    GoRoute(
      path: '/reorder',
      name: 'Reorderable',
      pageBuilder: (context, state) => MaterialPage(child: ReorderableListViewScreen()),
    ),
    GoRoute(
      path: '/custom',
      name: 'Custom',
      pageBuilder: (context, state) => MaterialPage(child: CustomScrollViewScreen()),
    ),
    GoRoute(
      path: '/scrollbar',
      name: 'Scrollbar',
      pageBuilder: (context, state) => MaterialPage(child: ScrollbarScreen()),
    ),
    GoRoute(
      path: '/refresh',
      name: 'Refresh',
      pageBuilder: (context, state) => MaterialPage(child: RefreshIndicatorScreen()),
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
