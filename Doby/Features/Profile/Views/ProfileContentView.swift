import SwiftUI

struct ProfileContentView: View {
    // Данные приходят снаружи, вью их не владеет
    let user: User
    let orders: [Order]
    var taget: ProfileTarget
    let profileNavigation: ProfileNavigation
    let onPhotoTap: () -> Void

    @Binding var currentPage: Int

    // Локальное UI-состояние, принадлежит только этой вью
    @State private var selection: ProfileDetailsTab = .about

    private var isOwner: Bool { taget == .currentUser }

    var body: some View {
        section {
            ProfileHeaderView(
                uuid: user.uuid,
                photo: user.photos?.first,
                username: user.username,
                firstName: user.firstName,
                lastName: user.lastName,
                cityName: user.city?.name,
                showPhotoGallery: onPhotoTap
            )
        }

        section {
            PrimaryCollapsibleSection(title: "Питомцы") {
                ProfilePetsView(
                    currentPage: currentPage,
                    pets: user.pets ?? [],
                    openPetAdding: profileNavigation.openPetAdding,
                    openPetProfile: profileNavigation.openPetProfile
                )
            }
        }

        section {
            PrimaryCollapsibleSection(title: "Подробнее") {
                ProfileDetailsView(
                    selection: $selection,
                    aboutValue: .about,
                    feedbackValue: .feedback,
                    options: ProfileDetailsTab.allCases,
                    title: { $0.rawValue },
                    bio: user.bio ?? "",
                    buttonAction: profileNavigation.openSettings
                )
            }
        }

        if isOwner {
            section {
                PrimaryCollapsibleSection(title: "История заказов") {
                    VStack(spacing: 12) {
                        ForEach(orders, id: \.self) { order in
                            PrimaryOrderCard(order: order)
                        }
                    }
                }
            }
        }
    }

    /// Единые отступы для всех секций
    private func section<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        content()
            .padding(.horizontal)
            .padding(.bottom, 10)
    }
}
