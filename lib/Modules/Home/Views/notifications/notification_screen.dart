// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CustomLiquidPullToRefresh extends StatefulWidget {
  const CustomLiquidPullToRefresh({super.key});

  @override
  State<CustomLiquidPullToRefresh> createState() =>
      _CustomLiquidPullToRefreshState();
}

class _CustomLiquidPullToRefreshState extends State<CustomLiquidPullToRefresh> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  late int refreshNum;
  late StreamController<int> _streamController;
  late ScrollController _scrollController;

  final List<String> _items = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
  ];

  @override
  void initState() {
    super.initState();
    refreshNum = 10;
    _streamController = StreamController<int>();
    _scrollController = ScrollController();
    _streamController.add(refreshNum);
  }

  @override
  void dispose() {
    _streamController.close();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        refreshNum = Random().nextInt(100);
      });
      _streamController.add(refreshNum);

      if (_scaffoldKey.currentState?.context != null) {
        ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
          SnackBar(
            content: const Text('Refresh complete'),
            action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Refresh error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data')),
      key: _scaffoldKey,
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        child: StreamBuilder<int>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _items.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                final String item = _items[index];
                return ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(child: Text(item)),
                  title: Text('This item represents $item.'),
                  subtitle: Text(
                    'Additional info. Refresh count: ${snapshot.data ?? refreshNum}',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
