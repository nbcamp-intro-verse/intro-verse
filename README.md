# IntroVerse

## Introduction

내일배움캠프 iOS 마스터 6기의 4조 팀원들을 소개하는 App입니다.<br>
[@meowbutlerdev](https://github.com/meowbutlerdev) [@sjang1594](https://github.com/sjang1594) [@seoyounghan](https://github.com/seoyounghan) [@minjae-L](https://github.com/minjae-L) [@youseokhwan](https://github.com/youseokhwan)

## Tech Stack

* Base: Xcode, Swift, iOS, Git
* UI: UIKit(Programmatic), AutoLayout, SnapKit
* Architecture: MVVM, Clean Architecture(Partially Implemented), Combine
* Dependency Management: Swift Package Manager
* etc: MetalKit

## Project Structure

```
├── IntroVerse
│   ├── Application
│   ├── Presentation
│   │   ├── Main
│   │   ├── JiSung
│   │   ├── MinJae
│   │   ├── Nick
│   │   ├── SeoYoung
│   │   └── SeokHwan
│   ├── Domain
│   ├── Data
│   ├── Utils
│   ├── Fonts
│   └── Assets.xcassets
└── IntroVerse.xcodeproj
```

## Usage

1. Clone Project

```bash
git clone https://github.com/nbcamp-intro-verse/intro-verse.git
cd intro-verse
open IntroVerse.xcodeproj
```

2. Run(⌘ + R)

## Features

| 뷰 이름       | 사진                                                                                                                                       | 설명                                                                                                                                                                                                       |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MainView      | ![MainView](https://github.com/user-attachments/assets/f2c33225-814a-4789-a10f-bb2b44aa3c6f)                                             | - 각각의 Profile Views 들을 CollectionView로 Horizontal 방향으로 Scroll 할 수 있게 구현 <br> - Background 이미지는 User didScroll 액션 시 해당 Profile view의 Blur image로 변경 |
| JiSungView    | ![JiSungView](https://github.com/user-attachments/assets/155fc9f4-e29e-45cc-96c5-0e5e39f93b1e)                                             | - 링크 클릭 시 웹 브라우저 연결 <br> - 버튼 클릭 시 아래 콘텐츠 내용 변경 <br> - 하단에 사용자 입력 값(메모)을 UserDefaults에 저장                                                                       |
| MinJaeView    | ![MinJaeView](https://github.com/user-attachments/assets/69db0348-bb83-4582-8a3a-96daeb57347a)                                             | - 메인 화면에서 선택한 카드의 이미지를 전체 배경화면으로 사용 <br> - 깃허브와 노션 버튼 클릭 시 Safari로 열람 <br> - 아래로 스크롤 시 상단 헤더 뷰 고정                                                            |
| NickView      | ![NickView](https://github.com/user-attachments/assets/b43e1e94-13cd-4786-af24-9c652939e9f4)                                               | - 화면의 약 4분의 1에 Rendering 기능 추가 <br> - [Ray Marching Animation w/ Metal Kit](https://www.notion.so/Ray-Marching-in-Mobile-Device-1acf2a8721a1803dabfde671a4164f44?pvs=21) <br> - 하단 Frame은 IntroView Page로 분리 <br> - Label (How to make pixel prettier?) <br> - 마지막 Frame에 2개의 flip card |
| SeoYoungView  | ![SeoYoungView](https://github.com/user-attachments/assets/cd7e52bf-31ce-4bf4-a327-226480a35352)                                             | - 아이콘 클릭 시 브라우저로 이동 <br> - UserDefaults를 이용한 간단한 메모 작성 및 수정 기능                                                                                                                   |
| SeokHwanView  | ![SeokHwanView](https://github.com/user-attachments/assets/7d9c2858-e7c5-41fa-8b4b-f05ec3bbad4b)                                             | - 상단에 프로필 이미지 표시 <br> - Blog, GitHub 버튼 클릭 시 해당 사이트로 이동 <br> - 하단에 MBTI, 관심사, 취미 등 키워드 나열 <br> - ScrollView 사용 <br> - MainView에서 present될 때 프로필 이미지에 Hero Animation 적용 |



## Team Convention

* [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/) 지향
* Commit Message Rule: [Udacity Commit Message Guide](https://udacity.github.io/git-styleguide/) 기반으로 작성
* PR: 팀원 4명 모두의 승인 후 merge(구두승인 ok)
