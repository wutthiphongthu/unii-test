# Project Structure Overview

เอกสารนี้อธิบายโครงสร้างโปรเจกต์ Flutter (`unii-test`) และหน้าที่ของแต่ละส่วน

## 1) โครงสร้างระดับสูง

```text
unii-test/
├── lib/
│   ├── app/
│   ├── core/
│   └── features/
│       └── coins/
├── assets/
│   ├── icons/
│   ├── images/
│   └── fonts/
├── test/
├── .vscode/
├── pubspec.yaml
└── README.md
```

## 2) จุดเริ่มต้นแอป

- `lib/main.dart`
  - เรียก `configureDependencies()` เพื่อ init DI ก่อน
  - จากนั้น `runApp(const UniiTestApp())`
- `lib/app/app.dart`
  - กำหนด `MaterialApp`, theme, route หลัก และ navigation ไปหน้า detail

## 3) Core Layer (`lib/core`)

- `constants/app_constants.dart`
  - ค่าคงที่ เช่น base URL, API version, page size, refresh interval
- `network/dio_client.dart`
  - ตั้งค่า `Dio` client, timeout, header token, และ interceptor/log
- `di/injection.dart`
  - จุดเรียกใช้งาน `get_it` + `injectable` (`getIt.init()`)
- `di/injection.config.dart`
  - ไฟล์ generated สำหรับ register dependency (ห้ามแก้มือ)
- `error/failures.dart`, `network/api_result.dart`
  - โครงสร้างพื้นฐานสำหรับ error/result (ถ้าใช้งานใน flow เพิ่มเติม)

## 4) Feature Layer: Coins (`lib/features/coins`)

ใช้แนวทางแยกชั้นแบบ Data / Domain / Presentation

### 4.1 Data

- `data/datasources/coin_remote_data_source.dart`
  - เรียก API จริงผ่าน `DioClient`
  - map response เป็น model
- `data/models/`
  - model สำหรับ parse JSON (`fromJson/toJson`)
  - มีไฟล์ generated `.g.dart` จาก `json_serializable`
- `data/repositories/coin_repository_impl.dart`
  - implement repository interface จาก domain
  - แปลง model -> entity

### 4.2 Domain

- `domain/entities/`
  - โครงสร้างข้อมูลที่ชั้น presentation ใช้งาน
- `domain/repositories/coin_repository.dart`
  - สัญญา (interface) ของการดึงข้อมูล
- `domain/usecases/`
  - กฎการเรียกใช้งานเชิงธุรกิจ เช่น `get_coins`, `get_coin_detail`

### 4.3 Presentation

- `presentation/bloc/`
  - จัดการ state/event ของหน้า list และ detail
  - มี auto refresh, load more, search
- `presentation/pages/`
  - โครงสร้างหน้าจอหลัก (`coin_list_page`, `coin_detail_page`)
- `presentation/widgets/`
  - widget ย่อย เช่น card, top rank section, bottom sheet

## 5) Dependency Injection

โปรเจกต์ใช้:

- `get_it` เป็น service locator
- `injectable` ช่วย generate การ register dependency

Dependency ถูกประกาศด้วย annotation เช่น:

- `@lazySingleton`
- `@injectable`
- `@LazySingleton(as: ...)`
- `@factoryParam` (กรณีต้องส่ง param ตอน resolve เช่น `coinId`)

จากนั้น generate ไปที่ `lib/core/di/injection.config.dart`

## 6) Assets

- `assets/icons/` ไอคอน SVG
- `assets/images/` ภาพประกอบ
- `assets/fonts/` ฟอนต์ Roboto (`Regular`, `SemiBold`, `Bold`)
- ผูกการใช้งานผ่าน `pubspec.yaml` และใช้ในธีมผ่าน `fontFamily: 'Roboto'`

## 7) Tests

- `test/features/coins/...`
  - test use case, bloc, widget
- `test/widget_test.dart`
  - ตัวอย่าง test ระดับแอป

## 8) Development Config

- `.vscode/launch.json`
  - profile สำหรับรันแบบมี token และไม่มี token
- `pubspec.yaml`
  - dependencies, assets, fonts, และ dev tooling

## 9) Data Flow (ภาพรวม)

```text
UI/Page -> Bloc -> UseCase -> Repository (interface) -> RepositoryImpl -> RemoteDataSource -> API
API response -> Model -> Entity -> Bloc State -> UI
```

## 10) หมายเหตุไฟล์ generated

ไฟล์ต่อไปนี้ถูก generate อัตโนมัติ ไม่ควรแก้มือ:

- `*.g.dart` (จาก `json_serializable`)
- `lib/core/di/injection.config.dart` (จาก `injectable_generator`)

ถ้ามีการเปลี่ยน model/annotation ให้รัน:

```bash
dart run build_runner build --delete-conflicting-outputs
```
