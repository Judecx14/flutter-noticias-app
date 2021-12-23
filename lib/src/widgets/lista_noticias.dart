import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);

  final List<Article> noticias;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  const _Noticia({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        _TarjetaTopBar(noticia: noticia, index: index),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaDescripcion(noticia: noticia),
        _TarjetaBotones(noticia: noticia),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({Key? key, required this.noticia}) : super(key: key);
  final Article noticia;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(
              Icons.more_outlined,
              color: Colors.green,
            ),
            onPressed: () async {
              await canLaunch(noticia.url!)
                  ? await launch(noticia.url!)
                  : throw '';
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.star_border,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _TarjetaDescripcion extends StatelessWidget {
  const _TarjetaDescripcion({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: noticia.description != null
            ? Text(noticia.description!)
            : const Text(""));
  }
}

class _TarjetaImagen extends StatelessWidget {
  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);
  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
            child: noticia.urlToImage != null
                ? FadeInImage(
                    placeholder: const AssetImage("assets/img/giphy.gif"),
                    image: NetworkImage(noticia.urlToImage!),
                  )
                : const Image(
                    image: AssetImage("assets/img/no-image.png"),
                  )),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  const _TarjetaTitulo({Key? key, required this.noticia}) : super(key: key);
  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        noticia.title!,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  const _TarjetaTopBar({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);
  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            "${index + 1}.",
            style: TextStyle(
              color: myTheme.colorScheme.primary,
            ),
          ),
          Text(
            "${noticia.source!.name}.",
          ),
        ],
      ),
    );
  }
}
