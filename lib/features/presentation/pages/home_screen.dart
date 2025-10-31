import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ============================================================================
// KONVERSI KE FLUTTER MODERN (DARI GETX)
// ============================================================================
// Perubahan:
// 1. GetView<HomeController> → StatelessWidget
// 2. Get.width → MediaQuery.of(context).size.width
// 3. Get.toNamed() → Navigator.pushNamed()
// 4. Responsive sizing: .wp (width percentage) → MediaQuery calculation
// 5. Constants dan Kategori tetap sama
// 6. Semua part widgets → integrated dalam file ini
// ============================================================================

// TODO: Import constants dan Kategori
// import '../../../domain/constant/constants.dart';
// import '../../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current Firebase user
    User? auth = FirebaseAuth.instance.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;

    // Helper functions untuk responsive sizing (.wp extension replacement)
    final wpValue = (percent) => screenWidth * (percent / 100);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              wpValue(4.0),
              wpValue(8.0),
              wpValue(4.0),
              wpValue(1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER: Logo + Profile Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TODO: Uncomment saat AppTexts constant ready
                    // Image.asset(
                    //   AppTexts.logo,
                    //   fit: BoxFit.cover,
                    //   width: screenWidth / 3,
                    // ),
                    SizedBox(width: screenWidth / 3),
                    InkWell(
                      onTap: () {
                        // TODO: Navigate ke Profile dengan route name
                        // Navigator.pushNamed(context, RouteName.profile);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Navigate to Profile'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: wpValue(10.0),
                          // TODO: Uncomment saat AppTexts constant ready
                          // child: Image.asset(
                          //   AppTexts.iconProfil,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Container(
                            color: Colors.grey,
                            child: const Icon(Icons.account_circle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // GREETING
                Row(
                  children: [
                    Text(
                      "Hay, ",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        // TODO: Use responsive font size
                        // fontSize: 16.0.sp,
                      ),
                    ),
                    Text(
                      "${auth?.displayName ?? 'User'} !",
                      // TODO: Uncomment saat styleBold16 ready
                      // style: styleBold16(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // HERO SECTION: Sertifikat & Kuis Stats
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: wpValue(4.0)),
                  child: const IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeHero(title: 'Sertifikat', score: '20'),
                        VerticalDivider(thickness: 2),
                        HomeHero(title: 'Kuis', score: '15'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // PROFIL PMII SECTION
                Text(
                  'Profil PMII',
                  // TODO: Uncomment saat styleBold20 ready
                  // style: styleBold20(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const HomeProfilePMII(),
                const SizedBox(height: 28),

                // KATEGORI KUIS SECTION
                Text(
                  'Kategori Kuis',
                  // TODO: Uncomment saat styleBold20 ready
                  // style: styleBold20(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const HomeKategoriKuis(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Hero Stats Widget
class HomeHero extends StatelessWidget {
  const HomeHero({super.key, required this.title, required this.score});

  final String title;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              // TODO: Use responsive font size
              // fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            score,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'Mogra',
              fontSize: 22,
              // TODO: Use responsive font size
              // fontSize: 22.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Profile PMII Horizontal Scroll Widget
class HomeProfilePMII extends StatelessWidget {
  const HomeProfilePMII({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment saat Kategori constant ready
    // const profileItems = Kategori.optionProfil;
    const profileItems = <Map<String, String>>[];

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      child: Row(
        children: [
          ...profileItems.map(
            (e) => SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    // TODO: Uncomment saat AppTexts constant ready
                    // image: DecorationImage(
                    //   opacity: 0.2,
                    //   fit: BoxFit.cover,
                    //   image: AssetImage(AppTexts.background),
                    //   scale: 0.2,
                    // ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    style: ListTileStyle.drawer,
                    title: Text(
                      '${e["title"]}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text('${e["subtitle"]}'),
                    // TODO: Uncomment saat AppTexts constant ready
                    // leading: Image.asset(AppTexts.logoPMII),
                    leading: const Icon(Icons.business),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

/// Kategori Kuis List Widget
class HomeKategoriKuis extends StatelessWidget {
  const HomeKategoriKuis({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment saat Kategori constant ready
    // const kategoriItems = Kategori.optionKategori;
    const kategoriItems = <Map<String, String>>[];

    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = kategoriItems[index];
          return InkWell(
            onTap: () {
              // TODO: Navigate ke List Quiz dengan category
              // Navigator.pushNamed(
              //   context,
              //   RouteName.listQuiz,
              //   arguments: item["title"],
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Navigate to: ${item["title"]}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.group_work_rounded,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  '${item["title"]}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('${item["subtitle"]}'),
              ),
            ),
          );
        },
        itemCount: kategoriItems.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
      ),
    );
  }
}
