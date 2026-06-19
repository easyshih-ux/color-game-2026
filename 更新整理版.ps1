$ErrorActionPreference = "Stop"

$sourceRoot = $PSScriptRoot
$targetRoot = Join-Path $sourceRoot "2026color_整理版"
$siteRoot = Join-Path $targetRoot "01_正式網站"
$teacherRoot = Join-Path $targetRoot "02_teacher_data"
$maintenanceRoot = Join-Path $targetRoot "03_maintenance"
$recordsRoot = Join-Path $targetRoot "04_development_records"

$directories = @(
  $siteRoot,
  (Join-Path $siteRoot "色彩學開場影片\開場"),
  $teacherRoot,
  (Join-Path $teacherRoot "QR"),
  (Join-Path $maintenanceRoot ".github\workflows"),
  $recordsRoot
)
$directories | ForEach-Object { New-Item -ItemType Directory -Path $_ -Force | Out-Null }

$siteFiles = @(
  "index.html", "hue-intro.html", "index01.html", "hue-password.html",
  "brightness-intro.html", "index02.html", "brightness-password.html",
  "chroma-intro.html", "index03.html", "chroma-password.html",
  "elements-intro.html", "elements-password.html", "evaluation new0618.html",
  "final-ending.html", "teacher-checkpoints.html", "game-timer.js", "social-preview.png"
)
foreach ($file in $siteFiles) {
  Copy-Item -LiteralPath (Join-Path $sourceRoot $file) -Destination (Join-Path $siteRoot $file) -Force
}

$openingAssets = @(
  "Startmovic3.mp4", "色相01.png", "明度01.png", "彩度01.png", "色彩三要素01.png",
  "色相通關.png", "明度通關.png", "彩度通關.png", "色彩三要素通關.png", "完美破關3.png"
)
foreach ($file in $openingAssets) {
  Copy-Item -LiteralPath (Join-Path $sourceRoot "色彩學開場影片\$file") -Destination (Join-Path $siteRoot "色彩學開場影片\$file") -Force
}
Copy-Item -LiteralPath (Join-Path $sourceRoot "色彩學開場影片\開場\Start0.png") -Destination (Join-Path $siteRoot "色彩學開場影片\開場\Start0.png") -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot "解謎圖片") -Destination $siteRoot -Recurse -Force

$teacherFiles = @{
  "評價收集.xlsx" = "evaluation-data.xlsx"
  "解答.xlsx" = "answers.xlsx"
  "接關密碼.gsheet" = "class-password.txt"
}
foreach ($entry in $teacherFiles.GetEnumerator()) {
  Copy-Item -LiteralPath (Join-Path $sourceRoot $entry.Key) -Destination (Join-Path $teacherRoot $entry.Value) -Force
}

$qrFiles = @{
  "學生版.png" = "student.png"
  "教師版.png" = "teacher.png"
  "學生版固定.png" = "student-fixed.png"
  "教師版固定.png" = "teacher-fixed.png"
  "列印.docx" = "print-layout.docx"
}
foreach ($entry in $qrFiles.GetEnumerator()) {
  Copy-Item -LiteralPath (Join-Path $sourceRoot "QR\$($entry.Key)") -Destination (Join-Path $teacherRoot "QR\$($entry.Value)") -Force
}

Copy-Item -LiteralPath (Join-Path $sourceRoot "generate_qr_codes.py") -Destination $maintenanceRoot -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot "optimize_game_images.py") -Destination $maintenanceRoot -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot "test.html") -Destination (Join-Path $maintenanceRoot "legacy-test-page.html") -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot ".github\workflows\deploy-pages.yml") -Destination (Join-Path $maintenanceRoot ".github\workflows\deploy-pages.yml") -Force

Copy-Item -LiteralPath (Join-Path $sourceRoot "開發紀錄\開發紀錄.md") -Destination (Join-Path $recordsRoot "development-log.md") -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot "開發紀錄\目前任務.md") -Destination (Join-Path $recordsRoot "current-tasks.md") -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot "開發紀錄\bug清單.md") -Destination (Join-Path $recordsRoot "bug-list.md") -Force

Write-Host "2026color 整理版已同步完成：$targetRoot"
