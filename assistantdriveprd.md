# AssistantDrive — Mahsulot Talablari Hujjati (PRD)

Versiya: 0.1  
Muallif: Sanjarbek17 (taklif)  
Sana: 2025-10-17

## 1. Kirish
AssistantDrive — yangi haydovchilarga yo‘l sharoitidagi tartibsizlik va stressni kamaytirish uchun mo‘ljallangan yordamchi tizim. Haydovchi telefonini (yoki avtomobil kameralarini) oynaga qarata o‘rnatadi, ilova video oqimini backendga yuboradi, server oqimni tahlil qilib marshrut va voqealar (xato yoki maslahatlar) haqida JSON shaklida ma'lumot qaytaradi. Ilova esa tekst-to-speech orqali haydovchini ogohlantiradi va kerakli tavsiyalarni beradi.

Mazkur hujjat tizimning funksional va nofunksional talablarini, foydalanuvchi hikoyalarini, ma'lumot formatini, xavfsizlik va sinov kriteriyalarini belgilaydi.

## 2. Maqsadlar va muvaffaqiyat mezonlari
- Maqsad: Yangi haydovchilarga yo‘l xatolarini kamaytirish, marshrutni osonlashtirish va xavfsiz haydashni qo‘llab-quvvatlash.
- Muvaffaqiyat mezonlari:
  - Xato yoki qoidabuzarlikni aniqlashdagi aniqlik ≥ 85% (kritik voqealar: yashirin burilish, chiziqdan chiqish, yo‘l qoidasi buzilishi).
  - Ogohlantirishlarga bo‘lgan kechikish (end-to-end) ≤ 1.5 soniya.
  - Foydalanuvchi mamnuniyati (NPS / so‘rovlar) ≥ 70% beta sinovda.
  - Bandwidth samaradorligi: video uchun mobil tarmoqda normal ishlash (1--2 Mbps sharoitida).

## 3. Maqsadli auditoriya
- Yangi haydovchilar (haydovchilik guvohnomasini olganiga 0–2 yil).
- Qisman tajribali haydovchilar — shahar va qiyin yo‘l sharoitlarida qo‘shimcha yordam istovchilar.
- Ta'lim markazlari va instructorlarga demonstratsiya va trening uchun qo‘llanma.

## 4. Foydalanuvchi senariylari (User Stories)
- F1: Men yangi haydovchi sifatida ilovani yoqsam, marshrut bo‘yicha oldindan eslatmalarni eshitishni istayman, shunda qayerda burilishni yoki chiziqni o‘zgartirishni bilib olaman.
- F2: Men yo‘l qoidasi buzilganda (masalan, trafik chizig‘idan chiqish) darhol ogohlantirish olishni xohlayman.
- F3: Ilova orqa kamerani ham ishlatib, orqa vaziyatni tahlil qilib ogohlantirish berishini istayman (masalan, orqa to‘qnashuv yoki yaqinlashish).
- F4: Men ma'lumotlarning maxfiy saqlanishini va ruxsatsiz ulashmasligini xohlayman.
- F5: Ilova xarajatlarni minimal saqlab, mobil tarmoqda uzluksiz ishlashga tayyor bo‘lsin.

## 5. Oscope (qamrab olinadi)
- Telefon (frontal kamera oynaga qaragan) orqali video oqimini yozish va real-vaqtda tahlil.
- Serverda video/vidoe-featuresni tahlil qilish (lane detection, lane departure, wrong turn, traffic sign detection, speed limit inference (GPS bilan), stop sign, pedestrian detection).
- JSON formatida tahlil natijasini qaytarish.
- Ilova orqali tekst-to-speech (TTS) ogohlantirishlarini real-vaqt yetkazish.
- Qo‘shimcha opsion: avtomobilga o‘rnatiladigan old va orqa kameralarga moslashuv va sinxron tahlil.

## 6. Out of scope (qamrab olinmaydi)
- To‘liq avtomatik boshqaruv (autopilot).
- SD karta/mahalliy keng ko‘lamli video arxivlash (faqat qisqa kritik kliplar eksporti).
- Kuchli qonuniy maslahat yoki sud uchun hujjatlashtirish (bunda maxsus funktsiyalar bo‘lishi mumkin, ammo boshlang‘ich fazada emas).

## 7. Funktsional talablar

1. Video qabul va uzatish
   - Telefon ilovasi frontal kameradan (yoki tashqi kameralardan) 720p@15-30fps ga yaqin oqimni kodlab, backendga uzatadi.
   - Qo‘llab-quvvatlanadigan protokollar: WebRTC yoki RTMP/HTTP-FLV (low-latency variant).
   - Video oqimi internet aloqasi uzilib qolsa, ilova lokal keshlash va qayta yuborish mexanizmini bajaradi.

2. Analiz va voqea aniqlash (backend)
   - Tashxis qilinadigan voqealar:
     - Lane Departure (yo‘l chizig‘idan chiqqanlik)
     - Lane Keep/Centering (markazda qolish)
     - Wrong Turn (noto‘g‘ri burilish yoki yo‘ldan chiqish)
     - Traffic Sign Recognition (stop, speed limit, pedestrian crossing)
     - Close Proximity Braking (oldingi mashinaga juda yaqinlashish)
     - Pedestrian Detection (yo‘l bo‘ylab piyodalar)
     - Rear collision risk deduced from rear camera (opsional)
   - Har bir voqea quyidagi JSON atributlarini qaytaradi:
     - timestamp (ISO 8601)
     - event_type (string)
     - confidence (0..1)
     - bounding_boxes / lane_coords (agar kerak bo‘lsa)
     - location: { latitude, longitude, accuracy } (agar GPS mavjud bo‘lsa)
     - suggested_action (string)
     - severity (low/medium/high)
   - Analiz kechikishi (inference latency) maqsadi: ≤ 1 s.

3. TTS va ogohlantirishlar (ilova qismi)
   - Ogohlantirish turlari:
     - Kritikal ogohlantirish (darhol ovoz: "To‘xtang! Xavf bor!") — prioritizatsiyalangan.
     - Ilova-tavsiyalar (yumshoqroq): "Chapga keyingi burilishga tayyorlaning".
     - Yo‘l bo‘yicha maslahatlar: "Speeds limit 60 km/h".
   - TTS ovoz balandligi va qayta takrorlash sozlamalari.
   - DND/Asosiy multimedia balansi: agar haydovchi telefonida qo‘ng‘iroq bo‘lsa, prioritet berish siyosati.

4. Sozlamalar va profiling
   - Foydalanuvchi profili: yangi/ tajribali, til (O‘zbek, Rus, Ingliz), TTS ovoz, sezgirlik darajasi.
   - Data retention: video kliplar va JSON eventlar uchun saqlash muddatini belgilash.

5. Kameralar va apparat qo‘llab-quvvatlash
   - Telefon frontal o‘rnatish uchun UI ko‘rsatmalar (kamera burchagi, stabil, daraxt/ oynaga reflekslarni kamaytirish).
   - Agar avtomobil kameralari ulanadigan bo‘lsa — 2 kanalli oqim (front + rear), sinxron tahlil.

## 8. Non-funksional talablar
- Latency: end-to-end ogohlantirish kechikishi ≤ 1.5 soniya.
- Ishonchlilik: tizim 99% vaqt ishlash.
- Skalalanish: yuklamaga qarab auto-skalable backend (microservices, containerized).
- Bandwidth optimallashtirish: mobil uchun adaptiv bitrate (ABR), past bitratda ham minimal qamrov.
- Xavfsizlik: TLS 1.2+ (yoki 1.3) bilan transport darajasida shifrlash; video va metama'lumotlar bazada shifrlangan (AES-256).
- Maxfiylik: GDPR/mahalliy qonunchilikka muvofiq foydalanuvchi roziligi, anonimlashtirish (yuqori qatlamda yuzni yoki raqam belgilarni anonimlashtirish opsiyasi).

## 9. Ma'lumot formati — JSON namunasi
{
  "timestamp": "2025-10-17T11:00:12Z",
  "events": [
    {
      "event_id": "evt_001",
      "event_type": "lane_departure",
      "confidence": 0.92,
      "severity": "medium",
      "lane_coords": [[x1,y1],[x2,y2],...],
      "suggested_action": "Chapga qayting va chiziqqa moslaning",
      "clip_url": "https://cdn.example.com/clips/evt_001.mp4"
    },
    {
      "event_id": "evt_002",
      "event_type": "speed_limit_detected",
      "confidence": 0.88,
      "severity": "low",
      "detected_value_kmh": 60,
      "suggested_action": "Tezlikni 60 km/soatga moslang"
    }
  ],
  "location": {"latitude": 41.311081, "longitude": 69.240562, "accuracy": 5}
}

## 10. TTS xabarlar — namunalar (O‘zbek tilida)
- Kritikal: "Diqqat! To‘xtang! Imminent collision." (agar inglizcha terminlar kerak bo‘lsa, tarjima bilan).
- Xato: "Siz yo‘l chizig‘idan chiqib ketmoqdasiz. Iltimos, markazga qayting."
- Maslahat: "Keyingi burilish: chap tomonda. 150 metrda buriling."
- Orqa kamera ogohlantirishi: "Orqadan juda yaqin. Masofani oshiring."

## 11. Integratsiya va API
- Endpoint: /v1/stream (WebRTC / RTMP) — video oqimi.
- Endpoint: /v1/events — POST JSON tahlil natijasi yoki GET so‘rovlar (real-time uchun websockets yoki server-sent events (SSE)).
- Auth: OAuth2 yoki API kalitlari mobil ilovalar uchun.
- Qo‘llab-quvvatlanadigan fayl/klip saqlash: signed URL orqali CDN-ga saqlash, 7-30 kun standart retention (sozlanadigan).

## 12. Monitoring va telemetriya
- Inference metrics: avg latency, p99 latency, inference errors.
- Event metrics: voqea turlari sanog‘i, confidence distribution.
- App metrics: stream drop rate, reconnects, bandwidth usage.
- Crash reporting va analytics (Sentry yoki shunga o‘xshash).

## 13. Test rejasi
- Unit testlar: har bir tahlil moduli uchun (lane detection, sign recognition).
- Integration testlar: ilova→stream→backend→TTS oqimi, end-to-end sinovlar.
- Real-world beta sinovi: 200+ soat real haydash va marshrutlarda (shahar, qishloq, kechki soatlar).
- Performance test: past bandwidth va yomon ko‘rish sharoitida aniqlikni sinash.

## 14. Lug‘at va qoidalar (definitions)
- Event: model tomonidan aniqlangan voqea (lane_departure, pedestrian, etc.).
- Confidence: modelning aniqlik ko‘rsatkichi (0-1).
- Critical event: to‘g‘ridan-to‘g‘ri xavf tug‘diruvchi holat (tez javob va ogohlantirish talab etiladi).

## 15. Risklar va ularni kamaytirish choralari
- Nota'kik aniqlik (false positive/negative): Modelni real dunyo datolari bilan takomillashtirish; threshold sozlamalari.
- Bandwidth cheklovlari: adaptiv bitrate, key-frames asosida faqat voqea paytida klip yuborish.
- Maxfiylik buzilishi: anonymous retention, ma'lumotlarni shifrlash, foydalanuvchi roziligi va opt-out.
- Yuridik masalalar (ma'lumotlarni saqlash va video): huquqiy maslahat va mahalliy qonunchilikka muvofiq siyosat.

## 16. Yo‘l xaritasi va milestones (bosqichlar)
- Bosqich 0 — Konsept & PRD (hozirgi hujjat) — 1 hafta.
- Bosqich 1 — Minimal Ishlab Chiqish (MVP): video stream → basic lane & sign detection → TTS ogohlantirishlar — 8–12 hafta.
- Bosqich 2 — Beta: real-world testing, model tuning, rear camera qo‘llab-quvvatlash — 12 hafta.
- Bosqich 3 — Ishlab chiqarish / keng tarqatish: skalalanish, xavfsizlik sertifikatlari, marketing — 8–12 hafta.

## 17. Qabul qilish mezonlari (Acceptance Criteria)
- Ilova real-vaqtda video oqimini yuboradi va backend 95% hollarda JSON eventni 1.5 soniya ichida qaytaradi.
- Beta sinovchilarning kamida 85% holatda tizimdan foydalanishdan mamnunligi.
- Klinik/real haydash sinovida critical event detection aniqligi ≥ 85%.
- TTS 3 ta asosiy tilni qo‘llab-quvvatlaydi (O‘zbek, Rus, Ingliz).

## 18. Qo‘shimcha: kamerani o‘rnatish bo‘yicha ko‘rsatmalar (UX)
- Telefon frontal kamerasi oynaga aniq va barqaror ko‘rinsin — stabilizer yoki dashboard mount tavsiya etiladi.
- Kamera burchagi: gorizontal markazni 30–40% ostida bo‘lishi kerak (yo‘lning ko‘proq erta qismi ko‘rsin).
- Yoritilish: kechasi ko‘rsatmalar va avtomatik balans uchun batareyaga yuklamaslik.