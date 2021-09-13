// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityAuthorization{
    
    var activities2 : FacilityActivities2!
    var assessments : FacilityAssessment!
    var canAccessAllTodos : Bool!
    var canAccessClinicalTodos : Bool!
    var canAccessRspTodos : Bool!
    var canAccessTodos : Bool!
    var canAddEditClinicalInfo : Bool!
    var canAddEditDeleteFacilityCalendar : Bool!
    var canAddRemoveLocalStaffFromRemotePatient : Bool!
    var canAddResidents : Bool!
    var canAddViewVitals : Bool!
    var canCopyRspConfiguration : Bool!
    var canEditIncidentReport : Bool!
    var canHideTodos : Bool!
    var canManageAppointments : Bool!
    var canManageBroadcast : Bool!
    var canManageCareTransition : Bool!
    var canManageCCM : Bool!
    var canManageCollaborators : Bool!
    var canManageCPX : Bool!
    var canManageCustomForms : Bool!
    var canManageDocuments : Bool!
    var canManageEmar : Bool!
    var canManageFacilityConfigurations : Bool!
    var canManageFacilityGroups : Bool!
    var canManageFamilyAnnouncements : Bool!
    var canManageLocation : Bool!
    var canManagePARDashboard : Bool!
    var canManageResidentTasks : Bool!
    var canManageServices : Bool!
    var canManageSocial : Bool!
    var canManageTaskSuspensions : Bool!
    var canManageTodos : Bool!
    var canManageUsers : Bool!
    var canManageVitals : Bool!
    var canMarkResidentTasks : Bool!
    var canModifyPharmacySchedule : Bool!
    var canPrintClinicalInfo : Bool!
    var canPrintCustomForms : Bool!
    var canPrintDocuments : Bool!
    var canPrintEmar : Bool!
    var canReportIR : Bool!
    var canSaveAndHoldIR : Bool!
    var canTakeEmergencyPrint : Bool!
    var canUpdateFacilityGroups : Bool!
    var canUpdateOrManageFacilityGroups : Bool!
    var canViewActivities : Bool!
    var canViewAllTodos : Bool!
    var canViewAppointmentTitleAndDescriptionOnly : Bool!
    var canViewAppointmentTitleOnly : Bool!
    var canViewCareLocations : Bool!
    var canViewCareTransition : Bool!
    var canViewClinicalInfo : Bool!
    var canViewCustomForms : Bool!
    var canViewDocuments : Bool!
    var canViewFacilityCalendar : Bool!
    var canViewFamilyEngagement : Bool!
    var canViewIncidentReport : Bool!
    var canViewManageClinicalInfo : Bool!
    var canViewNotes : Bool!
    var canViewPARDashboard : Bool!
    var canViewPatientEngagement : Bool!
    var canViewResidentInfo : Bool!
    var canViewResidentTasks : Bool!
    var canViewSecureMessaging : Bool!
    var canViewSocial : Bool!
    var canViewSsn : Bool!
    var canViewTodos : Bool!
    var canViewVitals : Bool!
    var clinicalReferral : FacilityClinicalReferral!
    var family : FacilityFamily!
    var hasCCIOSApp : Bool!
    var hasCCMApp : Bool!
    var hasNativeStaffApp : Bool!
    var hasSharedDocumentsApp : Bool!
    var hasTodosApp : Bool!
    var notes : FacilityNote!
    var rsp : FacilityRsp!
    var social : FacilitySocial!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let activities2Json = json["Activities2"]
        if !activities2Json.isEmpty{
            activities2 = FacilityActivities2(fromJson: activities2Json)
        }
        let assessmentsJson = json["Assessments"]
        if !assessmentsJson.isEmpty{
            assessments = FacilityAssessment(fromJson: assessmentsJson)
        }
        canAccessAllTodos = json["canAccessAllTodos"].boolValue
        canAccessClinicalTodos = json["canAccessClinicalTodos"].boolValue
        canAccessRspTodos = json["canAccessRspTodos"].boolValue
        canAccessTodos = json["canAccessTodos"].boolValue
        canAddEditClinicalInfo = json["canAddEditClinicalInfo"].boolValue
        canAddEditDeleteFacilityCalendar = json["canAddEditDeleteFacilityCalendar"].boolValue
        canAddRemoveLocalStaffFromRemotePatient = json["canAddRemoveLocalStaffFromRemotePatient"].boolValue
        canAddResidents = json["canAddResidents"].boolValue
        canAddViewVitals = json["canAddViewVitals"].boolValue
        canCopyRspConfiguration = json["canCopyRspConfiguration"].boolValue
        canEditIncidentReport = json["canEditIncidentReport"].boolValue
        canHideTodos = json["canHideTodos"].boolValue
        canManageAppointments = json["canManageAppointments"].boolValue
        canManageBroadcast = json["canManageBroadcast"].boolValue
        canManageCareTransition = json["canManageCareTransition"].boolValue
        canManageCCM = json["canManageCCM"].boolValue
        canManageCollaborators = json["canManageCollaborators"].boolValue
        canManageCPX = json["canManageCPX"].boolValue
        canManageCustomForms = json["canManageCustomForms"].boolValue
        canManageDocuments = json["canManageDocuments"].boolValue
        canManageEmar = json["canManageEmar"].boolValue
        canManageFacilityConfigurations = json["canManageFacilityConfigurations"].boolValue
        canManageFacilityGroups = json["canManageFacilityGroups"].boolValue
        canManageFamilyAnnouncements = json["canManageFamilyAnnouncements"].boolValue
        canManageLocation = json["canManageLocation"].boolValue
        canManagePARDashboard = json["canManagePARDashboard"].boolValue
        canManageResidentTasks = json["canManageResidentTasks"].boolValue
        canManageServices = json["canManageServices"].boolValue
        canManageSocial = json["canManageSocial"].boolValue
        canManageTaskSuspensions = json["canManageTaskSuspensions"].boolValue
        canManageTodos = json["canManageTodos"].boolValue
        canManageUsers = json["canManageUsers"].boolValue
        canManageVitals = json["canManageVitals"].boolValue
        canMarkResidentTasks = json["canMarkResidentTasks"].boolValue
        canModifyPharmacySchedule = json["canModifyPharmacySchedule"].boolValue
        canPrintClinicalInfo = json["canPrintClinicalInfo"].boolValue
        canPrintCustomForms = json["canPrintCustomForms"].boolValue
        canPrintDocuments = json["canPrintDocuments"].boolValue
        canPrintEmar = json["canPrintEmar"].boolValue
        canReportIR = json["canReportIR"].boolValue
        canSaveAndHoldIR = json["canSaveAndHoldIR"].boolValue
        canTakeEmergencyPrint = json["canTakeEmergencyPrint"].boolValue
        canUpdateFacilityGroups = json["canUpdateFacilityGroups"].boolValue
        canUpdateOrManageFacilityGroups = json["canUpdateOrManageFacilityGroups"].boolValue
        canViewActivities = json["canViewActivities"].boolValue
        canViewAllTodos = json["canViewAllTodos"].boolValue
        canViewAppointmentTitleAndDescriptionOnly = json["canViewAppointmentTitleAndDescriptionOnly"].boolValue
        canViewAppointmentTitleOnly = json["canViewAppointmentTitleOnly"].boolValue
        canViewCareLocations = json["canViewCareLocations"].boolValue
        canViewCareTransition = json["canViewCareTransition"].boolValue
        canViewClinicalInfo = json["canViewClinicalInfo"].boolValue
        canViewCustomForms = json["canViewCustomForms"].boolValue
        canViewDocuments = json["canViewDocuments"].boolValue
        canViewFacilityCalendar = json["canViewFacilityCalendar"].boolValue
        canViewFamilyEngagement = json["canViewFamilyEngagement"].boolValue
        canViewIncidentReport = json["canViewIncidentReport"].boolValue
        canViewManageClinicalInfo = json["canViewManageClinicalInfo"].boolValue
        canViewNotes = json["canViewNotes"].boolValue
        canViewPARDashboard = json["canViewPARDashboard"].boolValue
        canViewPatientEngagement = json["canViewPatientEngagement"].boolValue
        canViewResidentInfo = json["canViewResidentInfo"].boolValue
        canViewResidentTasks = json["canViewResidentTasks"].boolValue
        canViewSecureMessaging = json["canViewSecureMessaging"].boolValue
        canViewSocial = json["canViewSocial"].boolValue
        canViewSsn = json["canViewSsn"].boolValue
        canViewTodos = json["canViewTodos"].boolValue
        canViewVitals = json["canViewVitals"].boolValue
        let clinicalReferralJson = json["ClinicalReferral"]
        if !clinicalReferralJson.isEmpty{
            clinicalReferral = FacilityClinicalReferral(fromJson: clinicalReferralJson)
        }
        let familyJson = json["Family"]
        if !familyJson.isEmpty{
            family = FacilityFamily(fromJson: familyJson)
        }
        hasCCIOSApp = json["hasCCIOSApp"].boolValue
        hasCCMApp = json["hasCCMApp"].boolValue
        hasNativeStaffApp = json["hasNativeStaffApp"].boolValue
        hasSharedDocumentsApp = json["hasSharedDocumentsApp"].boolValue
        hasTodosApp = json["hasTodosApp"].boolValue
        let notesJson = json["Notes"]
        if !notesJson.isEmpty{
            notes = FacilityNote(fromJson: notesJson)
        }
        let rspJson = json["Rsp"]
        if !rspJson.isEmpty{
            rsp = FacilityRsp(fromJson: rspJson)
        }
        let socialJson = json["Social"]
        if !socialJson.isEmpty{
            social = FacilitySocial(fromJson: socialJson)
        }
    }

}
