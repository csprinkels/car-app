import SwiftUI

struct CarModelListView: View {
    let make: CarMake
    let dismiss: DismissAction
    @State private var searchText = ""
    @Binding var selectedCar: CarModel?
    
    var filteredModels: [CarModel] {
        if searchText.isEmpty {
            return make.models
        }
        return make.models.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List(filteredModels) { model in
            Button(action: {
                selectedCar = model
                dismiss()
            }) {
                CarModelRow(model: model)
            }
        }
        .navigationTitle(make.name)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search \(make.name) models")
    }
} 