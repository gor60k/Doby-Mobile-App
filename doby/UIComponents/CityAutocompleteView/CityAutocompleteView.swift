import SwiftUI

struct CityAutocompleteView: View {
    @Binding var selectedCity: City
    @State private var searchText: String = ""

    let cities = [
        City(name: "Москва", translit: "moskva"),
        City(name: "Санкт-Петербург", translit: "sankt-peterburg"),
        City(name: "Саратов", translit: "saratov")
    ]

    var filteredCities: [City] {
        if searchText.isEmpty { return [] }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var showSuggestions: Bool {
        !filteredCities.isEmpty && selectedCity.name != searchText
    }

    var body: some View {
        VStack {
            PrimaryTextField(title: "Введите город") {
                TextField("Введите город", text: $searchText)
            }

            if showSuggestions {
                VStack {
                    ForEach(filteredCities, id: \.name) { city in
                        Text(city.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                withAnimation {
                                    searchText = city.name
                                    selectedCity = city
                                }
                            }
                        Divider()
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary, lineWidth: 1))
                .transition(.opacity)
                .animation(.easeInOut, value: filteredCities)
            }
        }
    }
}

#Preview {
    ZStack {
//        CityAutocompleteView(selectedCity: .constant())
    }
    .padding()
}
