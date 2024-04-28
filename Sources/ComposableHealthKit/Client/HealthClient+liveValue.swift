import HealthKit

extension HealthClient {
    
    public static var liveValue: HealthClient {
        let healthStore = HKHealthStore()
        return HealthClient(
            isHealthDataAvailable: HKHealthStore.isHealthDataAvailable,
            supportsHealthRecords: healthStore.supportsHealthRecords,
            authorizationStatus: healthStore.authorizationStatus(for:),
            requestAuthorization: healthStore.requestAuthorization(toShare:read:),
            activityMoveMode: { try healthStore.activityMoveMode().activityMoveMode },
            biologicalSex: { try healthStore.biologicalSex().biologicalSex },
            bloodType: { try healthStore.bloodType().bloodType },
            dateOfBirthComponents: healthStore.dateOfBirthComponents,
            fitzpatrickSkinType: { try healthStore.fitzpatrickSkinType().skinType },
            wheelchairUse: { try healthStore.wheelchairUse().wheelchairUse },
            enableBackgroundDelivery: healthStore.enableBackgroundDelivery(for:frequency:),
            disableBackgroundDelivery: healthStore.disableBackgroundDelivery(for:),
            disableAllBackgroundDelivery: healthStore.disableAllBackgroundDelivery,
            earliestPermittedSampleDate: healthStore.earliestPermittedSampleDate,
            samples: { predicates, sortDescriptiors, limit in
                let queryDescriptor = HKSampleQueryDescriptor(
                    predicates: predicates,
                    sortDescriptors: sortDescriptiors,
                    limit: limit
                )
                return try await queryDescriptor.result(for: healthStore)
            },
            save: healthStore.save(_:),
            delete: healthStore.delete(_:)
        )
    }
}
