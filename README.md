# unii-test

คู่มือสำหรับคนที่ clone โปรเจกต์นี้แล้วต้องการรันให้ได้ทันที

## 1) เตรียมเครื่องก่อน

- ติดตั้ง Flutter SDK
- ติดตั้ง Dart SDK (มากับ Flutter)
- มี emulator หรืออุปกรณ์จริงสำหรับทดสอบ
- ใช้ IDE เช่น Cursor / VS Code / Android Studio

## 2) Clone โปรเจกต์

```bash
git clone <repo-url>
cd unii-test
```

## 3) ติดตั้ง dependencies

```bash
flutter pub get
```

## 4) Generate โค้ด (จำเป็นครั้งแรก)

โปรเจกต์นี้ใช้ code generation (`injectable`, `json_serializable`)  
ให้รันคำสั่งนี้หลัง clone เสมอ:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 5) วิธีรันแอป

โปรเจกต์มี launch config อยู่ที่ `/.vscode/launch.json` ให้เลือกได้ 2 แบบ:

- `Flutter (no token)`  
  รันแบบไม่ส่ง `COINRANKING_API_KEY`
- `Flutter (with Coinranking API key)`  
  รันแบบส่ง token ผ่าน `--dart-define`

ขั้นตอน:

1. เปิดเมนู **Run and Debug**
2. เลือก launch config ที่ต้องการ
3. กด **Run/Debug**

## 6) ถ้าต้องการใช้ API key ของตัวเอง

เปิดไฟล์ `/.vscode/launch.json` แล้วแก้ค่า:

```json
--dart-define=COINRANKING_API_KEY=YOUR_API_KEY
```

## 7) Remark (Rate Limit)

- ถ้า **ไม่ส่ง token** (`Flutter (no token)`) มีโอกาสเจอ rate limit ได้ง่าย
- เมื่อเจอ rate limit การเรียก API จะใช้งานไม่ได้ชั่วคราว และต้องรอสักพักก่อนลองใหม่
- ถ้าไม่อยากให้ติด rate limit แนะนำให้ส่ง `COINRANKING_API_KEY` ทุกครั้ง

## 8) คำสั่งที่ใช้บ่อย

```bash
# รัน unit/widget test
flutter test

# เช็ก warning/error ด้วย analyzer
flutter analyze
```
