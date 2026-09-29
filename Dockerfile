# tunnel-node پروژه‌ی mhrv-rs — نسخه‌ی پین‌شده (همون نسخه‌ی فایل VERSION پروژه‌ی اصلی)
FROM ghcr.io/therealaleph/mhrv-tunnel-node:1.9.37

# پورت پیش‌فرض؛ توی Railway می‌تونی با متغیر PORT عوضش کنی
ENV PORT=8080
EXPOSE 8080

