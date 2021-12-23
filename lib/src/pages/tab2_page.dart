import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Row(
                children: const [
                  Text(
                    "News",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "App",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const _ListaCategorias(),
            Expanded(
              child: newService.getArticulosByCategory.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListaNoticias(
                      noticias: newService.getArticulosByCategory,
                    ),

              /* ListaNoticias(noticias: newService.getArticulosByCategory), */
            )
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    final newService = Provider.of<NewsService>(context);

    return Container(
      width: double.infinity,
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cName = categories[index].name;
          return Container(
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _CategoryButton(category: categories[index]),
                  const SizedBox(height: 5.0),
                  Text(
                    '${cName[0].toUpperCase()}${cName.substring(1)}',
                    style: TextStyle(
                      color: newService.selectedCategory == cName
                          ? myTheme.colorScheme.primary
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = category.name;
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),
        child: Icon(
          category.icon,
          color: newService.selectedCategory == category.name
              ? myTheme.colorScheme.primary
              : Colors.white,
        ),
      ),
    );
  }
}
