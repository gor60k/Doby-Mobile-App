# ``Doby``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->

## Navigation
В проекте навигация построена на **generic router**.
### Основные принципы

1. Роутер отвечает только за выполнение переходов.
2. Каждый навигационный стек имеет собственный набор маршрутов (`Route`). Несмотря на одинаковый API роутеров, типы маршрутов различаются.
3. Экраны не должны знать, в каком навигационном стеке они находятся, и не должны зависеть сразу от нескольких роутеров.
4. Для этого используется система **Navigation Structure** — структуры, которые описывают доступные действия навигации для конкретного экрана. Они создаются на уровне навигационного стека и передаются в экран через зависимости.

### Правильно

```swift
struct ProfileNavigation {
    let openSettings: () -> Void
    let openDetails: (User.ID) -> Void
}

struct ProfileScreen: View {
    let navigation: ProfileNavigation

    var body: some View {
        Button("Settings") {
            navigation.openSettings()
        }
    }
}
```

Экран знает только о доступных действиях и не зависит от конкретного роутера.

### Неправильно

```swift
struct ProfileScreen: View {
    let appRouter: AppRouter
    let authRouter: AuthRouter

    var body: some View {
        Button("Settings") {
            appRouter.push(.settings)
        }
    }
}
```

В таком варианте экран становится привязан к реализации навигации, знает о нескольких навигационных стеках и его сложнее переиспользовать и тестировать.

