import 'package:flutter/material.dart';

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
  const ListQuisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get category dari arguments navigasi
    final category =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    // VARIABLE: Get subcategory berdasarkan kategori
    late List<String> subcategories;
    bool isValidCategory = true;

    switch (category) {
      case "MAPABA":
        // TODO: Uncomment saat Kategori constant ready
        // subcategories = Kategori.subcategoryMapaba;
        subcategories = []; // Placeholder
        break;
      case "PKD":
        // TODO: Uncomment saat Kategori constant ready
        // subcategories = Kategori.subcategoryPKD;
        subcategories = []; // Placeholder
        break;
      case "PKL":
        // TODO: Uncomment saat Kategori constant ready
        // subcategories = Kategori.subcategoryPKL;
        subcategories = []; // Placeholder
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
            title: subcategories[index],
            onTap: () {
              // TODO: Uncomment dan set route name yang sesuai
              // Navigator.pushNamed(
              //   context,
              //   RouteName.pretest,
              //   arguments: subcategories[index],
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Navigate ke: ${subcategories[index]}'),
                  duration: const Duration(seconds: 1),
                ),
              );
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
