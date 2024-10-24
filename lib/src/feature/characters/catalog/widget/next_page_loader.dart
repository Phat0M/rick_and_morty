import 'package:flutter/material.dart';

class NextPageLoader extends StatefulWidget {
  const NextPageLoader({
    required this.loadMore,
    super.key,
  });

  final VoidCallback loadMore;

  @override
  State<NextPageLoader> createState() => _NextPageLoaderState();
}

class _NextPageLoaderState extends State<NextPageLoader> {
  @override
  void initState() {
    super.initState();

    widget.loadMore();
  }

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
