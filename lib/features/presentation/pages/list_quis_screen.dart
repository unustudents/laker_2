import 'package:flutter/material.dart';
import 'package:laker_2/routes/app_router.dart';

import '../../../core/constant/constants.dart';

// ============================================================================
// KONVERSI KE FLUTTER MODERN (DARI GETX)
// ============================================================================
// Perubahan:
// 1. GetView<ListQuisController> → StatelessWidget
// 2. controller.dataArg → ModalRoute.of(context)?.settings.arguments
// 3. Get.toNamed() → Navigator.pushNamed()
// 4. Kategori constant tetap sama
// 5. PageNotFound widget tetap sama
// 6. ListQuisCard menjadi widget terpisah di file ini
// ============================================================================

// TODO: Import kategori dan page_not_found widget
// import '../../../domain/constant/kategori.dart';
// import '../../../domain/widget/page_not_found.dart';
// import '../../../routes/app_routes.dart';

class ListQuisScreen extends StatelessWidget {
  final String category;

  const ListQuisScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // VARIABLE: Get subcategory berdasarkan kategori
    late List<Map<String, dynamic>> subcategories;
    bool isValidCategory = true;

    switch (category) {
      case "MAPABA":
        subcategories = Kategori.subcategoryMapaba;
        break;
      case "PKD":
        subcategories = Kategori.subcategoryPKD;
        break;
      case "PKL":
        subcategories = Kategori.subcategoryPKL;
        break;
      default:
        isValidCategory = false;
    }

    // JIKA KATEGORI TIDAK VALID
    if (!isValidCategory) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Kategori tidak ditemukan', textAlign: TextAlign.center),
        ),
        // TODO: Uncomment saat PageNotFound widget ready
        // body: const PageNotFound(),
      );
    }

    // RETURN: List Kuis
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Kuis - $category'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, index) {
          return ListQuisCard(
            nomor: "${index + 1}",
            title: subcategories[index]['title'] as String,
            onTap: () {
              final idKategori = subcategories[index]['id'] as int;
              PretestRoute(idKategori: idKategori).go(context);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: subcategories.length,
      ),
    );
  }
}

/// List Quiz Card Widget
class ListQuisCard extends StatelessWidget {
  const ListQuisCard({
    super.key,
    required this.nomor,
    required this.title,
    this.onTap,
  });

  final String title;
  final String nomor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                nomor,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
