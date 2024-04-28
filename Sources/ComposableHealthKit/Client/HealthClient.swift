import Dependencies
import DependenciesMacros
import HealthKit

@DependencyClient
public struct HealthClient: DependencyKey, Sendable {
    
    /// Returns a Boolean value that indicates whether HealthKit is available on this device.
    ///
    /// See ``HKHealthStore.isHealthDataAvailable()`` for the details.
    public var isHealthDataAvailable: @Sendable () -> Bool = { false }
    
    /// Returns a Boolean value that indicates whether the current device supports clinical records.
    ///
    /// See ``HKHealthStore.supportsHealthRecords()`` for the details.
    public var supportsHealthRecords: @Sendable () -> Bool = { false }
    
    // MARK: Permission
    
    /// Returns the app’s authorization status for sharing the specified data type.
    ///
    /// See ``HKHealthStore.authorizationStatus(for:)`` for the details.
    public var authorizationStatus: @Sendable (
        _ for: HKObjectType
    ) -> HKAuthorizationStatus = { _ in .notDetermined }
    
    /// Asynchronously requests permission to save and read the specified data types.
    ///
    /// See ``HKHealthStore.requestAuthorization(toShare:read:)`` for the details.
    public var requestAuthorization: @Sendable (
        _ share: Set<HKSampleType>,
        _ read: Set<HKObjectType>
    ) async throws -> Void
    
    // MARK: Common
    
    /// Returns the activity move mode for the current user.
    ///
    /// See ``HKHealthStore.activityMoveMode()`` for the details.
    public var activityMoveMode: @Sendable () throws -> HKActivityMoveMode
    
    /// Reads someone’s biological sex from the HealthKit store.
    ///
    /// See ``HKHealthStore.biologicalSex()`` for the details.
    public var biologicalSex: @Sendable () throws -> HKBiologicalSex
    
    /// Reads the user’s blood type from the HealthKit store.
    ///
    /// See ``HKHealthStore.bloodType()`` for the details.
    public var bloodType: @Sendable () throws -> HKBloodType
    
    /// Reads the user’s date of birth from the HealthKit store as date components.
    ///
    /// See ``HKHealthStore.dateOfBirthComponents`` for the details.
    public var dateOfBirthComponents: @Sendable () throws -> DateComponents
    
    /// Reads the user’s Fitzpatrick Skin Type from the HealthKit store.
    ///
    /// See ``HKHealthStore.fitzpatrickSkinType()`` for the details.
    public var fitzpatrickSkinType: @Sendable () throws -> HKFitzpatrickSkinType
    
    /// Reads the user’s wheelchair use from the HealthKit store.
    ///
    /// See ``HKHealthStore.wheelchairUse()`` for the details.
    public var wheelchairUse: @Sendable () throws -> HKWheelchairUse
    
    // MARK: Background delivery
    
    /// Enables the delivery of updates to an app running in the background.
    ///
    /// See ``HKHealthStore.enableBackgroundDelivery(for:frequency:)`` for the details.
    public var enableBackgroundDelivery: @Sendable (
        _ for: HKObjectType,
        _ frequency: HKUpdateFrequency
    ) async throws -> Void
    
    /// Disables background deliveries of update notifications for the specified data type.
    ///
    /// See ``HKHealthStore.disableBackgroundDelivery(for:)`` for the details.
    public var disableBackgroundDelivery: @Sendable (_ for: HKObjectType) async throws -> Void
    
    /// Disables all background delivery of HealthKit data updates.
    ///
    /// See ``HKHealthStore.disableAllBackgroundDelivery()`` for the details.
    public var disableAllBackgroundDelivery: @Sendable () async throws -> Void
    
    // MARK: Samples
    
    /// Returns the earliest date permitted for samples.
    ///
    /// Attempts to save samples earlier than this date fail with
    /// an ``HKError.Code.errorInvalidArgument`` error.
    ///
    /// Attempts to query samples before this date return samples after this date.
    ///
    /// See ``HKHealthStore.earliestPermittedSampleDate`` for the details.
    public var earliestPermittedSampleDate: @Sendable () -> Date = { .distantPast }
    
    /// Runs a one-shot query and asynchronously returns a snapshot of the current matching results.
    ///
    /// See ``HKSampleQueryDescriptor`` for the details.
    public var samples: @Sendable (
        _ predicates: [HKSamplePredicate<HKSample>],
        _ sortDescriptors: [SortDescriptor<HKSample>],
        _ limit: Int?
    ) async throws -> [HKSample]
    
    // MARK: Updates
    
    /// Saves an array of objects to the HealthKit store.
    ///
    /// See ``HKHealthStore.save(_:)`` for the details.
    public var save: @Sendable (_ objcets: [HKObject]) async throws -> Void
    
    /// Deletes the specified objects from the HealthKit store.
    ///
    /// See ``HKHealthStore.delete(_:)`` for the details.
    public var delete: @Sendable (_ objcets: [HKObject]) async throws -> Void
}

extension DependencyValues {
    
    /// A dependency that provides an API to the HealthKit.
    public var healthClient: HealthClient {
        get { self[HealthClient.self] }
        set { self[HealthClient.self] = newValue }
    }
}
