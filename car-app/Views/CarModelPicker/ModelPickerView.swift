import SwiftUI

struct ModelPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @Binding var selectedCar: CarModel?
    
    var filteredMakes: [CarMake] {
        if searchText.isEmpty {
            return carMakes
        }
        return carMakes.filter { make in
            make.name.localizedCaseInsensitiveContains(searchText) ||
            make.models.contains { model in
                model.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredMakes) { make in
                NavigationLink {
                    CarModelListView(
                        make: make,
                        dismiss: dismiss,
                        selectedCar: $selectedCar
                    )
                } label: {
                    CarMakeRow(make: make)
                }
            }
            .navigationTitle("Select a Car")
            .searchable(text: $searchText, prompt: "Search makes and models")
        }
    }
} 