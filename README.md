# tunnel-node روی Railway (برای mhrv-rs)

این ریپو فقط یه `Dockerfile` داره که ایمیج رسمی tunnel-node پروژه‌ی mhrv-rs رو روی Railway اجرا می‌کنه.
⚠️ تست‌نشده: من (نویسنده‌ی این بسته) اجراش روی Railway رو امتحان نکردم.

## ⛔ خیلی مهم
- **AUTH رو توی گیت‌هاب نذار.** کلید فقط توی Railway (Variables) و توی اسکریپت Apps Script می‌ره.
- بهتره ریپوت **Private** باشه.
- نسخه‌ی پرشده‌ی `CodeFull.gs` رو commit نکن (توی `.gitignore` هست).

## مراحل

### ۱) ریپو
همین پوشه رو توی یه ریپوی جدید گیت‌هاب push کن (فایل‌ها: `Dockerfile`، `.gitignore`، ...).

### ۲) Railway
1. New Project ← **Deploy from GitHub repo** ← ریپوت رو انتخاب کن (Railway خودش `Dockerfile` رو پیدا می‌کنه).
2. تب **Variables** رو باز کن و اضافه کن:
   - `PORT` = `8080`
   - `TUNNEL_AUTH_KEY` = یه رشته‌ی رندوم (مثلاً خروجی `openssl rand -hex 16`؛ فقط حروف و عدد)
3. **Settings ← Networking ← Generate Domain** و پورت رو `8080` بذار.
4. توی **Logs** مطمئن شو کانتینر بالا اومده.

### ۳) Google Apps Script
1. فایل `google-apps-script/CodeFull.gs.template` رو توی script.google.com کپی کن (پروژه‌ی جدید).
2. اینا رو جایگزین کن:
   - `%%AUTH_KEY%%` (دو جا) ← همون کلید `TUNNEL_AUTH_KEY`
   - `%%TUNNEL_URL%%` ← آدرس دامنه‌ی Railway (مثلاً `https://xxx.up.railway.app`)
3. **Deploy ← New deployment ← Web app** (Execute as: Me، Who has access: Anyone).
4. **Deployment ID** رو کپی کن (با `AKfycb...` شروع می‌شه).
5. هر بار که اسکریپت رو عوض کردی، باید دوباره **New deployment** بزنی.

### ۴) اپ اندروید (mhrv-rs)
APK رو از github.com/therealaleph/MasterHttpRelayVPN-RUST/releases بگیر و وارد کن:
- Deployment ID (مرحله ۳)
- کلید AUTH
- Mode = **Full Tunnel (no cert)**

## اگه کار نکرد
- Logs رو توی Railway ببین.
- اگه کانتینر بالاست ولی اپ وصل نمی‌شه: مشکل احتمالاً `https` هست. مستندات mhrv فقط `http://IP:8080` رو توضیح می‌ده و `https` روش تست‌شده نیست.
- اگه Railway رایگان تموم شد، سرویس متوقف می‌شه؛ تونل باید ۲۴ ساعته روشن باشه.
- شرایط استفاده‌ی Railway از تونل/پروکسی رو خودت چک کن.
