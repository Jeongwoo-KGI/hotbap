<p  align="center">

<img  src="assets/images/hotbap.png"  alt="App Logo"  width="200">

</p>

## HotBap (핫밥) 🍚🔥 <br>

AI가 추천하는 건강한 레시피 앱
<br>

### 소개

핫밥은 Gemini AI와 식약처 API를 연동하여 사용자에게 맞춤형 레시피를 추천하는 앱입니다.
AI가 유저의 요구사항을 분석하고, 건강하고 맛있는 레시피를 자동으로 찾아 제공합니다.
<br>

### 특징

✅ AI 추천 레시피: Gemini AI가 사용자의 기분과 계절, 날씨를 고려하여 최적의 레시피를 추천합니다.
✅ 공식 데이터 기반: 식약처 API에서 제공하는 신뢰할 수 있는 레시피 정보를 활용합니다.
✅ 편리한 레시피 검색: 원하는 재료나 요리를 입력하면 관련 레시피를 찾아볼 수 있습니다.
✅ 찜(즐겨찾기) 기능: 마음에 드는 레시피를 저장하고 언제든지 다시 볼 수 있습니다.
<br>

## 팀원 구성

**박채은**

- 마이 페이지, 찜한 리스트 페이지, 로그아웃, 회원 탈퇴 기능, 필터페이지 UI

**김고은**

- 검색 페이지, Gemini API를 이용한 검색 기능, 식약처 API 연결

**박정우**

- 홈 페이지, 필터 페이지, Gemini API를 이용한 추천 기능

**윤지윤**

- 프로젝트 기획, 피그마를 이용한 UI, UX

**고성훈**

- 로그인 페이지, 회원가입 페이지, 상세페이지, 찜 기능

<br>

### 프로젝트 일정

**25/01/16 ~ 25/02/06**

<br>

## 📌 **주요 기능**

### 1. **피드 작성 및 읽기**

- **피드 작성**: 유저와 유저가 설정한 AI만이 글을 작성할 수 있습니다.

- **피드 목록**: 유저가 작성한 글과 AI가 작성한 글이 표시 됩니다.

- 유저가 글 작성 후 일정 시간이 지나면 AI가 새 게시글과 답글을 작성하여 업로드 합니다.

### 2. **데이터 관리**

- `Firebase`를 이용하여 데이터를 저장 및 관리리합니다.

### 3. **기능별 페이지 구성**

#### **로고 페이지 (`logo_page`)**

- 스플래시를 이용하여 로고를 표시합니다.

#### **로그인인 페이지 (`login_page`)**

- 구글 계정으로 .

#### **피드 페이지 (`feed_page`)**

- 유저가 작성한 글과 AI가 작성한 글이 표시 됩니다.

#### **상세 페이지(`detail_page`)**

- 작성된 글과 답글을 확인할 수 있습니다.

- 답글을 작성할 수 있습니다.

#### **글 작성 페이지(`create_page`)**

- 글을 작성하여 DB에 저장할 수 있습니다.

- 이미지 인식을 통해 `사람`이 찍힌 사진은 업로드 되지 않습니다.

#### **마이 페이지(`my_page`)**

- 유저의 프로필 이미지를 변경할 수 있습니다.

- 가입시 초기 설정한 AI의 성격을 변경할 수 있습니다.

#### **염탐 페이지(`업데이트 예정`)**

- 다른 유저의 게시글을 확인할 수 있습니다.

- 본인의 게시글을 공개하려면 마이페이지에서 공개여부 설정을 해야 합니다.

---

## 🛠️ **기술 스택**

- **Framework**: Flutter

- **Language**: Riverpod

- **State Management**: `p`

- **Data Handling**: Firebase

- **EasyRichText**: 로그인시 텍스트 효과

- **TensorFlow Lite_YOLOv8**: 이미지 인식

- **Image Picker**: 내장된 사진 가져옴

- **Go router**: 화면 이동시 사용

- **Google_sign_in**: 구글 계정으로 회원 가입 및 로그인

- **Firebase_crashlytics**: 오류 로그 메세지 기록

- **Firebase_Database**:Database 사용

- **Friebase_authentication**: 소셜 로그인 관리

- **Firebase_Functions**: 설정한 시간에 AI가 게시글 등록할 때 사용

- **Firebase_App Check**: 앱 무결성 체크

---

## TroubleShooting

#### 구글 계정으로 로그인 시도시 로그인 되지 않 이슈

1. 문제 정의

- 구글 계정으로 로그인 시도시 앱에 로그인 되지 않는 현상 .

2. 사실 수집

- PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)

위와 같은 오류 메세지 발생

- 다른 팀원들은 모두 정상 동작함

3. 원인 추론

- SHA-1 키 또는 계정에 문제 있을 것으로 예

4. 조사 방법 결정

- 구글 검색, 챗gpt 이용, 튜터님께 문의

- 참고 블로그 :[https://velog.io/@zinkiki/FlutterAndroid-Unhandled-Exception-PlatformExceptionsigninfailed-com.google.android.gms.common.api.ApiException-10-null-null](https://velog.io/@zinkiki/FlutterAndroid-Unhandled-Exception-PlatformExceptionsigninfailed-com.google.android.gms.common.api.ApiException-10-null-null)

5. 조사 방법 구현

- SHA-1 키 재확인 → 효과 없음

- 에뮬레이터 교체 → 효과 없음

- google-services.json 삭제 후 다운 받아 사 → 효과 없음

- 키 삭제 후 재설치 → 효과 없음(블로그 참고)

- 빌드 할 때 참고한 키 확인하여 firebase에 입력 → 정상 작동(튜터님께서 알려주심)

![이미지](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdXsiho%2FbtsLFA9p8bT%2FX7wTU5FWvZIbSxdkfiBeXk%2Fimg.png)

- 위치 : build\app\outputs\flutter-apk\

명령어 : keytool -printcert -jarfile app-debug.apk

6. 결과 관찰

- build\app\outputs\flutter-apk\위치에서 명령어를 실행시켜 나온 키값을 기존 입력한 키와 비교시 다르다는 것을 확인

- 해당 키로 교체하여 시도시 정상 작동 확인

- 원인은 파악 불가

---

## 🚀 **설치 및 실행**

### 1. **Flutter 설치**

Flutter가 설치되어 있지 않다면 [Flutter 설치 가이드](https://docs.flutter.dev/get-started/install)를 참고하세요.

- **프로젝트 클론**

```

git clone git@github.com:A1-AONE/SOLO_NETWORK_SNS/git

cd help-me

```

- **의존성 설치**

```

flutter pub get

```

## 🏂 **향후 개선 방향**

### 1. **염탐 기능 구현**

- 다른 사람의 작성글을 몰래 보려는 염탐 기능을 구현할 예정입니다.

### 2. **UI 개선**

- 사용자 경험을 바탕으로 UI를 더욱 개선할 예정입니다.

## 🏂 **관련 URL**

### 1. **시연 영상**

-https://www.youtube.com/watch?v=lwXD4P_BsOc

### 2. **트러블슈팅**

- https://tutle02.tistory.com/58
