import 'package:flutter/material.dart';

class FutureBuilderSetup<T> extends StatelessWidget {
  const FutureBuilderSetup(
      {super.key,
      required this.getData,
      required this.builderSuccess,
      required this.builderFailed});

  final Future<T> getData;
  final Widget Function(String) builderFailed;
  final Widget Function(T) builderSuccess;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return builderFailed("Failed to load data");
          } else {
            return builderSuccess(snapshot.data as T);
          }
        });
  }
}
