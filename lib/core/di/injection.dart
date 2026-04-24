import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:unii_test/core/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

// กำหนดให้ Injectable ใช้งานการ generate โค้ด DI ด้วย initializerName ที่กำหนด, ใช้ relative imports และกำหนดให้เป็น extension บน GetIt
@InjectableInit(
  initializerName: 'init', // ชื่อ initializer method ที่จะถูก generate
  preferRelativeImports: true, // ใช้ relative import ในไฟล์ที่ถูก generate
  asExtension: true, // สร้างเป็น extension บน GetIt แทนการสร้างฟังก์ชันปกติ
)
Future<void> configureDependencies() async {
  getIt.init();
}
