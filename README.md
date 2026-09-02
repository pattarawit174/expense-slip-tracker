# ระบบจัดเก็บข้อมูลจากใบเสร็จโอนเงินเพื่อบันทึกรายจ่ายภายในครัวเรือน

ระบบบันทึกรายรับ-รายจ่ายอัตโนมัติจากใบเสร็จโอนเงิน (e-Slip) ผ่าน LINE Messaging API
โดยใช้ n8n เป็น Workflow Automation, Google Gemini สำหรับ OCR/Information Extraction
และ Supabase (PostgreSQL) เป็นฐานข้อมูล

## โครงสร้างโปรเจกต์

```
.
├── n8n/
│   └── workflow.json        # n8n workflow export (credential/webhook ID ถูกเบลอแล้ว)
└── database/
    ├── create_table_public_users.sql
    ├── create_table_public_expenses.sql
    ├── create_table_public_documents2.sql
    └── create_view_public_monthly_summary.sql
```

## การตั้งค่า (Setup)

1. สร้างตารางและ view ในฐานข้อมูล Supabase ตามลำดับในโฟลเดอร์ `database/`
   (ตรวจสอบว่าเปิดใช้งาน extension `pgvector` แล้ว ก่อนรัน `create_table_public_documents2.sql`)
2. นำเข้าไฟล์ `n8n/workflow.json` เข้า n8n instance ของคุณ
3. ตั้งค่า Credentials ใหม่ในหน้า n8n (Supabase API, HTTP Header Auth สำหรับ LINE,
   Google Gemini API) เนื่องจาก credential ID เดิมถูกลบออกจากไฟล์นี้เพื่อความปลอดภัย
4. อัปเดต Webhook ID/Path ในโหนด LINE Webhook และ Dashboard Webhook ใหม่ตามที่ n8n สร้างให้

## หมายเหตุด้านความปลอดภัย

ไฟล์ `n8n/workflow.json` ผ่านการเบลอข้อมูลต่อไปนี้แล้วก่อนเผยแพร่:
- Credential ID ของ Supabase, HTTP Header Auth (LINE), Google Gemini API
- Webhook ID/Path ของ LINE Webhook และ Dashboard Webhook
- Instance ID ของ n8n

**ก่อน push ทุกครั้ง** ควรตรวจสอบไฟล์ที่จะเพิ่มใหม่ว่าไม่มี API key, token,
หรือ credential จริงหลุดติดไปด้วย
