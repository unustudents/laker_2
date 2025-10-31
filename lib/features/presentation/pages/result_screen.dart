import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// import 'package:get/get.dart';
// import 'controllers/result.controller.dart';

// class ResultScreen extends GetView<ResultController> {
//   const ResultScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final value = Get.arguments;
//     const int dot = 70;
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         color: Colors.white,
//         child: Column(
//           children: [
//             // TOMBOL CLOSE
//             // Align(alignment: Alignment.topRight, child: CloseButton(onPressed: () => Get.back())),

//             // TEXT -- HASIL KUIS
//             const SizedBox(height: 25),
//             Text(
//               'RESULT',
//               style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 25),

//             // PERSENTASE KEBERHASILAN
//             CircularPercentIndicator(
//               radius: 80.0,
//               lineWidth: 20.0,
//               animation: true,
//               animationDuration: 1000,
//               percent: value / 100,
//               center: Text.rich(
//                 TextSpan(
//                   text: value.toString(),
//                   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 40.0),
//                   children: const [
//                     TextSpan(text: '%', style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               ),
//               circularStrokeCap: CircularStrokeCap.round,
//               backgroundColor: Colors.transparent,
//               progressColor: Colors.amberAccent,
//             ),
//             const SizedBox(height: 25),

//             // TEKS -- MENYATAKAN
//             Text(
//               'Menyatakan :',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 10),

//             // TEKS -- KETERANGAN LOLOS
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//               color: value <= dot ? Colors.redAccent.shade200 : Colors.greenAccent.shade200,
//               child: Text(value <= dot ? 'BELUM BERHASIL' : 'BERHASIL',
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
//             ),
//             const SizedBox(height: 20),

//             // TEKS -- KETERANGAN
//             Text(
//               value <= dot
//                   ? 'Anda belum berhasil \n silahkan mengikuti kuis dilain waktu. \n terimakasih'
//                   : 'Sertifikat keberhasilan akan diberikan panitia paling lama 3 x 24 jam',
//               style: Theme.of(context).textTheme.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//             const Spacer(),

//             // TOMBOL NEXT KE HOME
//             SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => print('Selesai'), child: const Text('FINISH')))
//           ],
//         ),
//       ),
//     );
//   }
// }

// ============================================================================
// KONVERSI KE FLUTTER MODERN
// ============================================================================
// Perubahan utama:
// 1. GetView → StatelessWidget (screen ini hanya display, tidak ada state management)
// 2. Get.arguments → constructor parameter (score)
// 3. Get.back() → Navigator.pop(context)
// 4. UI tetap identik
// 5. CircularPercentIndicator untuk progress visualization tetap sama
// 6. Conditional rendering berdasarkan score (pass/fail) tetap sama
// 7. Const int dot = 70 tetap sebagai passing threshold

class ResultScreen extends StatelessWidget {
  /// Score dari quiz (0-100)
  final int score;

  /// Passing threshold (default 70)
  static const int passingThreshold = 70;

  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final isPassed = score > passingThreshold;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            // TOMBOL CLOSE
            Align(
              alignment: Alignment.topRight,
              child: CloseButton(onPressed: () => Navigator.pop(context)),
            ),

            // TEXT -- HASIL KUIS
            const SizedBox(height: 25),
            Text(
              'RESULT',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25),

            // PERSENTASE KEBERHASILAN
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 20.0,
              animation: true,
              animationDuration: 1000,
              percent: score / 100,
              center: Text.rich(
                TextSpan(
                  text: score.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40.0,
                  ),
                  children: const [
                    TextSpan(text: '%', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.transparent,
              progressColor: Colors.amberAccent,
            ),
            const SizedBox(height: 25),

            // TEKS -- MENYATAKAN
            Text('Menyatakan :', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),

            // TEKS -- KETERANGAN LOLOS/TIDAK LOLOS
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              color: isPassed
                  ? Colors.greenAccent.shade200
                  : Colors.redAccent.shade200,
              child: Text(
                isPassed ? 'BERHASIL' : 'BELUM BERHASIL',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            // TEKS -- KETERANGAN HASIL
            Text(
              isPassed
                  ? 'Sertifikat keberhasilan akan diberikan panitia paling lama 3 x 24 jam'
                  : 'Anda belum berhasil \n silahkan mengikuti kuis dilain waktu. \n terimakasih',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Spacer(),

            // TOMBOL NEXT KE HOME
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('FINISH'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
