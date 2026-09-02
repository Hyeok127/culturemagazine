# 알고보면 (가제) — 문화 교양 웹매거진

> 알고 보면 더 보이고, 알고 들으면 더 들립니다.

영화 · 촬영기법 · 영화음악 · 대중음악 · 클래식 — 감상 뒤에 숨은 이야기를 **사전지식 없이** 읽을 수 있게 풀어주는 매거진.
빌드 도구 없는 정적 사이트(HTML + CSS)라서 어디에든 그대로 올리면 됩니다.

## 폴더 구조

```
algobomyeon-site/
├── index.html                      # 홈
├── article-*.html                  # 발행된 글 (5비트 구조)
├── hub-{film,cine,score,pop,classic}.html   # 장르 허브 5
├── series.html                     # 시그니처 시리즈 7
├── paths.html                      # 입문 경로(코스)
├── about.html                      # 소개 · 구독 · 문의
├── assets/css/style.css            # 디자인 시스템 (색·서체·컴포넌트 전부 여기)
├── cardnews/<글>.html              # 인스타 카드뉴스 원본 (1080×1350 × 8장)
├── cardnews/out/*.png              # 렌더된 카드뉴스 이미지
└── scripts/render-cardnews.ps1     # 카드뉴스 PNG 렌더 스크립트
```

## 로컬에서 보기

폴더에서 아무 정적 서버나 띄우면 됩니다. 예:

```bash
python -m http.server 8735
```

→ http://localhost:8735

## 배포 (외부 공개)

### 방법 A — GitHub Pages (무료, 권장)

1. github.com → **New repository** → 이름 `algobomyeon-site`, **Public** 선택(무료 Pages는 Public 저장소만), README 추가 없이 생성.
2. 이 폴더에서 원격 저장소를 연결하고 올립니다 (`<아이디>`는 본인 GitHub 아이디):

   ```bash
   git remote add origin https://github.com/<아이디>/algobomyeon-site.git
   ```

   ```bash
   git push -u origin main
   ```

3. 저장소 **Settings → Pages → Build and deployment → Source: Deploy from a branch → Branch: main / (root) → Save**.
   몇 분 뒤 `https://<아이디>.github.io/algobomyeon-site/` 에서 열립니다. (모든 링크가 상대경로라 하위 주소에서도 그대로 동작합니다.)

### 방법 B — Netlify Drop (계정만 있으면 드래그 한 번)

https://app.netlify.com/drop 에 이 폴더를 통째로 드래그하면 즉시 임시 주소가 생깁니다.

## 글 추가하는 법

1. `article-interstellar-organ.html`을 복사해 파일명을 바꿉니다 (`article-<주제>.html`).
2. `<title>`, `description`, 키커(시리즈 · 장르), 제목, 본문을 바꿉니다. 본문은 **5비트 구조**를 지킵니다:
   느낌(무엇이 좋았나) → 정체(그게 뭔가) → 원리(왜 그렇게 작동하나) → 히스토리(어디서 왔나) → 다시보기(이제 뭐가 다르게 보이나)
3. 전문용어는 `<span class="term">용어</span>(일상어 풀이)` 형태로 첫 등장에서 바로 풉니다.
4. 글 끝 "여기서 이어지는 길"에 다른 장르로 넘어가는 링크 2~3개를 답니다.
5. 홈(`index.html`) · 해당 장르 허브 · `series.html`에서 제목에 링크를 겁니다. **링크 없는 제목 = 발행 예정 예시**가 사이트 규칙입니다.

## 카드뉴스 만드는 법

1. `cardnews/interstellar-organ.html`을 복사해 8장 내용을 바꿉니다 (표지 → 느낌 → 정체 → 원리 → 의미 → 히스토리 → 마지막 CTA).
2. PowerShell에서 렌더 스크립트를 실행하면 `cardnews/out/`에 1080×1350 PNG 8장이 생깁니다:

   ```powershell
   .\scripts\render-cardnews.ps1 -Html .\cardnews\interstellar-organ.html -Prefix interstellar-organ
   ```

   (Google Chrome이 설치돼 있어야 합니다. 브라우저에서 `cardnews/<파일>.html`을 열면 8장을 한 번에 미리 볼 수 있습니다.)

## 디자인 규칙 요약

- 바탕은 항상 종이색 `#FAF7F2`, 글자는 잉크 `#211D19`, 포인트는 `#8C3A33`.
- 장르색 5종(영화 `#8C3A33` · 촬영기법 `#8A6A33` · 영화음악 `#3F5E78` · 대중음악 `#7A4979` · 클래식 `#47664F`)은 키커와 카드뉴스 표지 배경에만.
- 제목은 Hahmlet, 본문은 Gothic A1 (Google Fonts).
- 별점·랭킹·평가 언어 금지. 과장·낚시 제목 금지. 사실은 확인된 것만.
