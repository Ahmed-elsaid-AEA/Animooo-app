import 'package:flutter/material.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({super.key});

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("animal page");
    super.build(context);
    return const Scaffold();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}
