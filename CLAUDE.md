# KiiBOOM Cybrix 16 맵퍼

Cybrix 16 키 설정 사이트 (맥 + 윈도우). `index.html` 하나로 동작(WebHID, Chrome/Edge), localhost:8716에서 실행.
- 맥: `Cybrix16 맵퍼 열기 (맥).command` / 윈도우: `Cybrix16 맵퍼 열기 (윈도우).bat` → `windows/serve.ps1` (PowerShell HttpListener, index.html만 서빙)
- 헤더의 🍎 맥 / 🪟 윈도우 전환은 표시·단축키 프리셋만 바꿈 (localStorage `cybrix16-os`). 키보드엔 같은 키코드가 저장됨
- 저장소: https://github.com/withdino/KiiBOOM (private)

## 기기 정보
- VID `0x5343` / PID `0x0080`, VIA raw HID(usage page `0xFF60`, usage `0x61`), **VIA 프로토콜 v12** (최신 QMK 키코드)
- 매트릭스 5행 × 4열, 레이어 6개, 매크로 20개(버퍼 3743바이트)
- 노브: 왼쪽 작은 노브 = 인코더 0 / 누르기 (4,2), 오른쪽 작은 노브 = 인코더 1 / 누르기 (4,1), 큰 노브 = 인코더 2 / 누르기 (4,3)
- 큰 노브 누르기 = 다음 레이어로 이동 (`TO(n+1)`, 마지막 레이어는 `TO(0)`)

## 용어 (사용자와 약속)
- **키 번호**: 4×4 키를 왼쪽 위부터 오른쪽으로 1~16번이라 부름. 왼쪽 위 = 1번, 오른쪽 아래 = 16번.
  - n번 키 → row = (n-1) / 4, col = (n-1) % 4
- **레이어 이름** (0부터 셈, 작은 노브 아래 표시등 색):

| 레이어 | 색 |
|---|---|
| 0 | Red |
| 1 | Green |
| 2 | Deep Blue |
| 3 | Yellow |
| 4 | Pink |
| 5 | Blue |

## 현재 맞춤 설정
- **2 Deep Blue · 1번 키 = F18 (`0x006D`)** → Raycast 앱 단축키로 Claude 데스크톱 열기/전환 (실행 안 되어 있으면 실행)
  - 맥 쪽 연결: Raycast → Settings → Extensions → Applications → Claude → Hotkey = F18
- **2 Deep Blue · 9번 키 = F19 (`0x006E`)** → 노션 앱에서 페이지 열기
  - 스크립트: `raycast-scripts/open-notion-page.sh` (`open "notion://app.notion.com/p/074f2ed18d1e43dfbbb04f3598932110"` — 반드시 노션 앱으로 열기 위해 `notion://` 사용)
  - 주의: `notion://www.notion.so/<id>`는 노션 앱(7.x)이 `/p/` 없는 깨진 주소로 바꿔서 안 됨. 반드시 `notion://app.notion.com/p/<id>` 형식 (`?source=...` 제거)
  - 맥 쪽 연결(실제 사용): Raycast Quicklink, Link = 위 notion:// 주소, Open With = Notion, Hotkey = F19
  - (대안) Raycast → Settings → Extensions → Script Commands → Add Directories → `raycast-scripts` 폴더 추가 → "노션 페이지 열기" Hotkey = F19

## 키 추가 규칙
- 앱/페이지 열기 같은 맥 동작은 키보드에 안 쓰는 키(F13~F24)를 지정하고 Raycast에서 연결. 사용 중: F18, F19
