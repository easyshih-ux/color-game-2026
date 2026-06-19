# 2026color 學生 iPad 網站白名單

- 掃描日期：2026-06-19
- 對應遊戲版本：0eb144e
- 掃描範圍：正式學生流程、教師測試頁、動態跳轉、`fetch`、`window.open`、外部表單與專案內歷史候選頁

## 給資訊組的建議白名單

### 必須允許

| 網域或網址範圍 | 用途 | 未允許時的影響 |
| --- | --- | --- |
| `https://easyshih-ux.github.io/color-game-2026/` | 遊戲本體、影片、圖片、題目、QR 目標頁 | 遊戲無法開啟 |
| `https://script.google.com/macros/s/` | 接關密碼核對、遊戲評價送出 | 無法接關或送出評價 |
| `https://script.googleusercontent.com/macros/` | Apps Script 執行後的重新導向與 JSON 回應 | 接關密碼可能一直顯示連線失敗 |
| `https://forms.gle/Vwa1LS5wUF56WYxy8` | 彩度作品上傳短網址 | 無法開啟作品上傳 |
| `https://docs.google.com/forms/` | Google 表單正式頁面與檔案上傳 | 表單無法載入或上傳 |
| `https://accounts.google.com/` | Google 表單登入 | 目前表單要求登入，未允許會停在登入頁 |

### Google 表單支援網域

建議一併允許，避免表單畫面空白、登入元件缺失或檔案上傳失敗：

- `www.gstatic.com`
- `ssl.gstatic.com`
- `fonts.gstatic.com`
- `fonts.googleapis.com`
- `apis.google.com`
- `drive.google.com`
- `content.googleapis.com`
- `*.googleusercontent.com`

若管理系統不接受萬用字元，至少加入 `script.googleusercontent.com` 與 `lh3.googleusercontent.com`。

## 可直接貼入 MDM 的網域清單

```text
easyshih-ux.github.io
script.google.com
script.googleusercontent.com
forms.gle
docs.google.com
accounts.google.com
www.gstatic.com
ssl.gstatic.com
fonts.gstatic.com
fonts.googleapis.com
apis.google.com
drive.google.com
content.googleapis.com
*.googleusercontent.com
```

全部使用 HTTPS，連接埠為 `443`。

## 正式學生流程跳轉

| 來源頁面 | 跳轉目標 | 類型 |
| --- | --- | --- |
| `index.html` | `hue-intro.html` | 正常開始 |
| `index.html` | `brightness-intro.html` | 通過班級接關密碼後 |
| `hue-intro.html` | `index01.html` | 色相開場後 |
| `index01.html` | `hue-password.html` | 色相學習驗收 |
| `hue-password.html` | `brightness-intro.html` | 色相驗收完成 |
| `brightness-intro.html` | `index02.html` | 明度開場後 |
| `index02.html` | `brightness-password.html` | 明度學習驗收 |
| `brightness-password.html` | `chroma-intro.html` | 明度驗收完成 |
| `chroma-intro.html` | `index03.html` | 彩度開場後 |
| `index03.html` | `chroma-password.html` | 彩度學習驗收 |
| `index03.html` | Google 表單 | 作品上傳，開啟新分頁 |
| `chroma-password.html` | `elements-intro.html` | 彩度驗收完成 |
| `elements-intro.html` | `elements-password.html` | 最後驗收 |
| `elements-password.html` | `evaluation new0618.html` | 色彩三要素驗收完成 |
| `evaluation new0618.html` | `final-ending.html` | 評價後前往完美破關 |

以上本地頁面全部位於 `easyshih-ux.github.io/color-game-2026/`，不需要逐頁建立不同網域規則。

## 教師測試頁跳轉

`teacher-checkpoints.html` 只會跳到同一個 GitHub Pages 網站內的完整遊戲、三階段開場、Index01-03 內部關卡、六個分段驗收、色彩三要素驗收、評價與完美破關。教師更新接關密碼時，另會使用相同的 `script.google.com` 與 `script.googleusercontent.com`。

## 外部服務完整清單

### 接關密碼 Apps Script

```text
https://script.google.com/macros/s/AKfycbx8jiW2JVvejI3wGGKwLl5PsqE00H1-osnz1-qAf80L7B8_rtKSfwX7EUW-szenJj9kBQ/exec
```

### 評價寫入 Apps Script

```text
https://script.google.com/macros/s/AKfycbzPOELjeAbjP2jpsJ2YajVDUHxADdCQEcYyov-eot6-ofzHXh_J8xU1fr9yvBaFQBLixw/exec
```

### 作品上傳 Google 表單

```text
https://forms.gle/Vwa1LS5wUF56WYxy8
https://docs.google.com/forms/d/e/1FAIpQLSeSkmB4TG-NF1_tFRpatRmpwJR1SWyX5epdTNbIHGnyGLecPQ/viewform
```

## 不需加入學生白名單

- `github.com`：只供開發者管理程式，學生不會前往。
- Facebook 網域：首頁分享資訊只供 Facebook 抓取，不會讓學生 iPad 連到 Facebook。
- `sites.google.com`、`csp.withgoogle.com`：只存在於保留的舊 Google Sites 網頁快照，不在正式遊戲流程。
- 舊版 `evaluation.html`、`evaluation new.html`、`evaluation_google_sheet.html`：均非正式流程。
- 本地圖片、影片、WebP 與 `data:` 下載網址：由遊戲本站或瀏覽器本機處理，不需額外網域。

## iPad 設定與驗收

1. 允許 Safari 的 Cookie、JavaScript、Local Storage 與開啟新分頁。
2. 允許學生從照片圖庫或檔案 App 選取作品，供 Google 表單上傳。
3. 先登入學校 Google 帳號，再測試作品上傳；未登入時目前表單會轉到 `accounts.google.com`。
4. 依序測試：掃描學生 QR、播放開場、班級接關、開啟作品表單、送出評價。
5. 若遊戲能開但接關失敗，優先檢查 `script.googleusercontent.com`。
6. 若表單能開但無法上傳，優先檢查 Google 帳號、`drive.google.com` 與 `*.googleusercontent.com`。

## 掃描驗證結果

- 遊戲首頁：HTTP 200。
- 接關密碼 Apps Script：HTTP 200，並重新導向至 `script.googleusercontent.com`。
- 評價 Apps Script：HTTP 200。
- 作品表單：短網址會轉到 `docs.google.com`；未登入測試時回應 401 並要求前往 `accounts.google.com`，符合目前表單的登入需求。
