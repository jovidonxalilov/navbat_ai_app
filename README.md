# navbat_ai_app

A new Flutter project.
## 📺 Demo _video

👉_ [Youtubeda vide ko'rish](https://youtu.be/CbTpBCODqr8?si=Z0xI2cHWCmzFboMn)


## Getting Started

- Foydalanuvchining navbatdagi holatini (status) kuzatish
- Real vaqt rejimida (Stream orqali) status o‘zgarishini aniqlash
- Holat o‘zgarganda mobil qurilmada bildirishnoma ko‘rsatish
- UI orqali foydalanuvchiga:
    - Navbat raqami
    - Telefon raqami
    - Status
    - Progress ko‘rsatkichi (tayyorlik darajasi)

---

## ⚙️ Ishlash prinsipi

### 1. Bloc orqali ma'lumot olish
- `HomeBloc` ishga tushganda `HomeStarted` eventi chaqiriladi.
- Backend (odatda WebSocket yoki Firestore stream) bilan ulanish o‘rnatiladi.
- Har safar foydalanuvchining ma'lumotida o‘zgarish bo‘lsa, yangi `state.profile` keladi.

### 2. Real vaqt rejimida kuzatish
- Sahifada `BlocConsumer` ishlatiladi:
    - `builder` - UI holatga qarab yangilanadi.
    - `listener` - foydalanuvchining `status`i o‘zgarsa, `NotificationService` orqali push xabar yuboriladi.

```dart
if (user.status != previousStatus) {
  previousStatus = user.status;
  NotificationService.showStatusNotification(...);
}


- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
