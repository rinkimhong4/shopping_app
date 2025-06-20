import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshListScreen extends StatefulWidget {
  final bool? noLeading;
  const PullToRefreshListScreen({super.key, this.noLeading});

  @override
  State<PullToRefreshListScreen> createState() =>
      _PullToRefreshListScreenState();
}

class _PullToRefreshListScreenState extends State<PullToRefreshListScreen> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  List<String> items = List.generate(15, (index) => "Item ${index + 1}");

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      items = List.generate(15, (index) => "Refreshed Item ${index + 1}");
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      items.addAll(
        List.generate(5, (index) => "Loaded Item ${items.length + index + 1}"),
      );
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull To Refresh'),
        leading: widget.noLeading == true ? SizedBox() : null,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: WaterDropHeader(),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder:
              (context, index) => ListTile(
                title: Text(items[index], style: TextStyle(fontSize: 18)),
              ),
        ),
      ),
    );
  }
}
