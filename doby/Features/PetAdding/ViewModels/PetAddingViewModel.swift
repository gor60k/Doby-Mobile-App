import Foundation
import _PhotosUI_SwiftUI
import os
import Observation
import PhotosUI

@Observable
final class PetAddingViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var petStorage = PetStorage.shared
    private var log = LogService.shared
    
    private var petService: PetServiceProtocol
    
    private let logger = Logger(
        subsystem: "com.app.subsystem",
        category: "PetAddingViewModel"
    )
    
    var petType: PetType = .dog
    var name: String = ""
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var breedName: String = ""

    var description: String = ""
    var selectedPhotoItems: [PhotosPickerItem] = []
    var selectedPhotosData: [Data] = []

    var feedingType: String = ""
    var feedingSchedule: String = ""
    var feedingNotes: String = ""
    
    var warningInput: String = ""
    var featureInput: String = ""

    var warningTags: [String] = []
    var featureTags: [String] = []
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(
        petService: PetServiceProtocol = PetService()
    ) {
        self.petService = petService
    }
    
    enum TagKind {
        case warning
        case feature
    }

    func isAddButtonDisabled(for kind: TagKind) -> Bool {
        trimmedTagInput(tagInput(for: kind)).isEmpty
    }

    func addTag(_ kind: TagKind) {
        let trimmed = trimmedTagInput(tagInput(for: kind))
        guard !trimmed.isEmpty else { return }

        var currentTags = tags(for: kind)
        guard !currentTags.contains(trimmed) else {
            setTagInput("", for: kind)
            return
        }

        currentTags.append(trimmed)
        setTags(currentTags, for: kind)
        setTagInput("", for: kind)
    }

    func removeTag(_ tag: String, from kind: TagKind) {
        let updatedTags = tags(for: kind).filter { $0 != tag }
        setTags(updatedTags, for: kind)
    }

    private func tagInput(for kind: TagKind) -> String {
        switch kind {
        case .warning:
            return warningInput
        case .feature:
            return featureInput
        }
    }

    private func setTagInput(_ value: String, for kind: TagKind) {
        switch kind {
        case .warning:
            warningInput = value
        case .feature:
            featureInput = value
        }
    }

    private func tags(for kind: TagKind) -> [String] {
        switch kind {
        case .warning:
            return warningTags
        case .feature:
            return featureTags
        }
    }

    private func setTags(_ value: [String], for kind: TagKind) {
        switch kind {
        case .warning:
            warningTags = value
        case .feature:
            featureTags = value
        }
    }
    
    private func trimmedTagInput(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isAddWarningButtonDisabled: Bool {
        isAddButtonDisabled(for: .warning)
    }

    var isAddFeatureButtonDisabled: Bool {
        isAddButtonDisabled(for: .feature)
    }

    func addWarningTag() {
        addTag(.warning)
    }

    func addFeatureTag() {
        addTag(.feature)
    }

    func removeWarningTag(_ tag: String) {
        removeTag(tag, from: .warning)
    }

    func removeFeatureTag(_ tag: String) {
        removeTag(tag, from: .feature)
    }
    
    @MainActor
    func loadSelectedPhotos() async {
        selectedPhotosData = []

        for item in selectedPhotoItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                selectedPhotosData.append(data)
            }
        }
    }
    
    @MainActor
    func addPet() async {
        isLoading = true
        errorMessage = nil
        
        await log.logAsync("ADDPET", logger: logger) {
            let request = PetRequest(
                pet_type: petType.toDTO(),
                name: name,
                age: age,
                height: height,
                weight: weight,
                breed_name: breedName,
            )
            
            let response = try await petService.create(request)
            
            petStorage.appendPet(response.toDomain())

//            name = ""
//            age = 0
//            height = 0
//            weight = 0
//            breedName = ""
//            description = ""
//            selectedPhotoItems = []
//            selectedPhotosData = []
//            feedingType = ""
//            feedingSchedule = ""
//            feedingNotes = ""
//            warningInput = ""
//            warningTags = []
//            featureTags = []
//            pets = session.currentPets ?? []
        }
        
        isLoading = false
    }
}
