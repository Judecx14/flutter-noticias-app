import 'package:flutter/material.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/src/services/news_service.dart';

//Para mantener el estado de un widget cuando hacemos scroll
//Es necesario hacer que el widget sea statful para poder heredar
//la clase AutomaticKeepAliveClientMixin esta implementara un metodo
//que sirvira para mantener el estado

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: headlines.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListaNoticias(
              noticias: headlines,
            ),
    );
  }

  //Este es el metodo que permite mantener el estado
  @override
  bool get wantKeepAlive => true;
}
