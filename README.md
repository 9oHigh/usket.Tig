# TimeBox Planner (타임박스 플래너)
<br>
<!--프로젝트 대문 이미지 및 배지-->
<div align="center">
  <img src="https://github.com/user-attachments/assets/7514e8b9-f0ac-49ba-b36e-3d87bb0a029f" alt="Project Title" width="600">
  <br><br>
  <img src="https://img.shields.io/badge/Google Play에서 만나기 🚀-000000?style=for-the-badge&logo=googleplay&logoColor=white">
</div>
<br>

<!--목차-->
## 목차
- [TimeBox Planner (타임박스 플래너)](#timebox-planner-타임박스-플래너)
  - [목차](#목차)
  - [About the Project](#about-the-project)
  - [Structure](#structure)
  - [Technologies](#technologies)
  - [트러블 슈팅, 성과](#트러블-슈팅-성과)

## About the Project
- Notion에서 타임 박스 플래너 템플릿을 사용하다가, 앱으로 만들어보면 어떨까 생각해 프로젝트를 진행하게 되었습니다.
- 주요 기능
  - 우선순위 3개, 브레인 덤프, 할 일 목록을 작성하고, 체크박스를 통해 완료 처리를 할 수 있습니다.
  - 현재 진행 중인 작업과 남아있는 시간(타이머)을 실시간으로 확인할 수 있습니다.
    - 앱 내에서 이를 티그 모드(Tig: time is gold   )라고고 지칭합니다.
  - 안드로이드 위젯을 만들어 적용했습니다.
    - 하루 단위의 위젯은 당일진행 상황을을 표시합니다.
    - 월 단위의 위젯은 한 달간의 기록을, 달력을 통해 표시합니다.
      - 깃허브의 잔디처럼 특정한 수치에 따라 서로 다른 컬러를 사용
    - 두 위젯 모두, 일 혹은 월이 변경되면 자동으로 업데이트합니다.
  - 태그를 추가해 반복적인 작업을 쉽게 입력할 수 있도록 만들었습니다.
    - 키보드가 화면에 보일 때, 키보드 위에 리스트를 표시하고, 이를 클릭 시 텍스트가 입력 및 다음 텍스트 필드로 이동하도록 만들었습니다.
- 기간
  - 2024.9.8~2024.10.20
  - 약한 달 정도의 기간을 가지고 개발했습니다.

## Structure
    ```
    ├── lib
    │   ├── core
    │   │   ├── di
    │   │   ├── manager
    │   │   ├── routes
    │   │   └── theme
    │   ├── data
    │   │   ├── datasources
    │   │   ├── models
    │   │   └── repositories
    │   ├── domain
    │   │   ├── entities
    │   │   ├── repositories
    │   │   └── usecases
    │   ├── presentation
    │   │   ├── providers
    │   │   ├── screens
    │   │   └── widgets
    │   └── utils
    │   │   └── extentions
    │   ├── main.dart
    ```

## Technologies
- **Google Signin**과 **Kakao Signin**를 통해 로그인을 진행합니다.
  - Google Signin의 경우, Firebase의 Authentication이 적용되므로 별도의 코드가 필요하지 않았습니다.
  - Kakao Signin의 경우, 온전히 사용하기 위해서는 Firebase의 Authentication에서 로그인 방법을 커스텀 해야 하기에 kakao 사용자 정보를 토대로 가상의 이메일을 만들어 회원가입을 진행했습니다.
- **Firestore**를 통해 사용자들의 정보를 저장
  - 날짜별 데이터, 사용자 정보 등을 저장합니다.
- **get_it** 패키지를 통해 의존성 관리, **Riverpod**을 통해 상태 관리
  - get_it을 통해 datasource, repository, usecase 들의 의존성을 관리합니다.
  - Riverpod을 통해 state, stateNotifier, stateNotifierProvider 전역 변수 및 클래스를 생성해 상태 관리를 합니다. stateNotifierProvider의 경우, AutoDispose 클래스로 생성해 메모리 누수를 방지합니다.
- **Clean Architecture** 적용
  - data, domain, presentation 계층을 구축하고, 각 계층에 맞는 작업을 진행합니다.
  - data: firestore에서 데이터를 가져오는 역할 등을 수행합니다.
  - domain: 가져온 데이터를 presentation에 전달하기 전에 비즈니스 로직 등을 수행합니다.
  - presentation: 받아온 데이터를 화면에 표시합니다. 이때, riverpod의 상태 관리를 통해 화면을 갱신하는 시점을 제어합니다.
- **다국어 적용** (중국어 간체자와 번체자를 포함해 8개 국어 적용)
  - [devstory님의 블로그](https://blog.devstory.co.kr/post/flutter-i18n-01/)를 참고해 구축했습니다. 감사합니다.

## 트러블 슈팅, 성과
- Riverpod에 대한 이해도를 높이는 데 중점을 두고 프로젝트를 진행했습니다.
  - 초기 Riverpod을 다루기 어려웠으나 리팩토링을 진행하면서 조금씩 알아가고 있습니다.

- 예시 ) Screen 위젯 내부에서 로그인을 위한 메서드를 추가해 사용했었고, Screen에서 사용되는 상태들(ex - isLoading 등)을 setState를 통해 관리하고 있었습니다.

  ```dart
  Future<void> _signInWithGoogle(authProvider) async {
      if (!_isAnimationCompleted) return;
      setState(() {
          _isLoading = true;
      });
      // ...

      try {
          await authProvider.signInWithGoogle();
          // ...
      } catch (e) {
          // ...
      } finally {
          setState(() {
              _isLoading = false;
          });
      }
  }
  // ...
  ```
- 이를 해결하기 위해 3개의 클래스 및 변수를 사용했습니다.
  - state 클래스
    ```dart
    class AuthState extends Equatable {
        final bool isAnimationCompleted;
        final bool isLoading;
        final String message;
        final bool isLoggedIn;

        const AuthState({
            this.isAnimationCompleted = false,
            this.isLoading = false,
            this.message = "",
            this.isLoggedIn = false,
        });

        const AuthState.initial({
            this.isAnimationCompleted = false,
            this.isLoading = false,
            this.message = "",
            this.isLoggedIn = false,
        });

        AuthState copyWith({
            bool? isAnimationCompleted,
            bool? isLoading,
            String? message,
            bool? isLoggedIn,
        }) {
            return AuthState(
                isAnimationCompleted: isAnimationCompleted ?? this.isAnimationCompleted,
                isLoading: isLoading ?? this.isLoading,
                message: message ?? this.message,
                isLoggedIn: isLoggedIn ?? this.isLoggedIn,
            );
        }

        @override
        List<Object?> get props => [isAnimationCompleted, isLoading, message, isLoggedIn];
    }
    ```
    - AuthScreen에서 사용될 상태 클래스를 생성
      - 초기 화면 진입시, 애니메이션 완료 처리를 위한 isAnimationCompleted
      - 로그인시, 프로그래스바 표시를 위한 isLoading
      - 오류를 표시하기 위한 message
      - 로그인에 성공했을 경우, homeScreen으로 이동하기 위한 isLoggedIn
      - copyWith를 통해 상태를 변경하고, 화면을 다시 빌드
  - notifier 클래스
    ```dart
    class AuthNotifier extends StateNotifier<AuthState> {
        final AuthUseCase _authUseCase = injector.get<AuthUseCase>();

        AuthNotifier() : super(const AuthState());

        Future<void> signInWithGoogle() async {
            if (!state.isAnimationCompleted) return;

            state = state.copyWith(isLoading: true, message: "");
            try {
                await _authUseCase.signInWithGoogle();
                await SharedPreferenceManager().setPref<bool>(PrefsType.isLoggedIn, true);
                state = state.copyWith(
                    message: Intl.message('auth_google_login_success'),
                    isLoggedIn: true,
                    isLoading: false,
                );
            } catch (e) {
                state = state.copyWith(
                    message:
                        Intl.message('auth_google_login_failure', args: [e.toString()]),
                    isLoading: false);
            }
        }
        // ...
        void setAnimationCompleted(bool isCompleted) {
            state = state.copyWith(isAnimationCompleted: isCompleted);
        }
    }
    ```
  - stateNotifierProvider 전역 변수
    - authNotifierProvider를 통해 로그인을 완료했을 때, 더이상 사용할 필요가 없기 때문에 AutoDispose를 통해서 폐기해 메모리를 관리합니다.
    ```dart
    final authNotifierProvider =
        AutoDisposeStateNotifierProvider<AuthNotifier, AuthState>(
            (ref) => AuthNotifier());
    ```
