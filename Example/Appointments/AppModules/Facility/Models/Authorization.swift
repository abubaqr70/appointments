// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Authorization : Codable {
    
	let canViewResidentInfo : Bool?
	let canPrintEmar : Bool?
	let canManageFacilityConfigurations : Bool?
	let canViewPARDashboard : Bool?
	let canManagePARDashboard : Bool?
	let canPrintClinicalInfo : Bool?
	let canViewResidentTasks : Bool?
	let canViewDocuments : Bool?
	let canManageCareTransition : Bool?
	let canAddRemoveLocalStaffFromRemotePatient : Bool?
	let canManageCPX : Bool?
	let hasCCMApp : Bool?
	let canAccessClinicalTodos : Bool?
	let canManageTodos : Bool?
	let canAddEditDeleteFacilityCalendar : Bool?
	let canViewAllTodos : Bool?
	let canEditIncidentReport : Bool?
	let hasNativeStaffApp : Bool?
	let canViewSsn : Bool?
	let clinicalReferral : ClinicalReferral?
	let canViewManageClinicalInfo : Bool?
	let canManageAppointments : Bool?
	let canTakeEmergencyPrint : Bool?
	let canManageFacilityGroups : Bool?
	let canManageResidentTasks : Bool?
	let canModifyPharmacySchedule : Bool?
	let canManageBroadcast : Bool?
	let assessments : Assessments?
	let canHideTodos : Bool?
	let canManageTaskSuspensions : Bool?
	let canViewNotes : Bool?
	let canSaveAndHoldIR : Bool?
	let canManageSocial : Bool?
	let canViewPatientEngagement : Bool?
	let canPrintCustomForms : Bool?
	let canManageDocuments : Bool?
	let hasTodosApp : Bool?
	let canViewSocial : Bool?
	let notes : Notes?
	let canUpdateOrManageFacilityGroups : Bool?
	let canAccessAllTodos : Bool?
	let hasSharedDocumentsApp : Bool?
	let canViewTodos : Bool?
	let canAccessRspTodos : Bool?
	let canViewCareLocations : Bool?
	let activities2 : Activities2?
	let canAccessTodos : Bool?
	let canViewCareTransition : Bool?
	let canManageFamilyAnnouncements : Bool?
	let canManageCCM : Bool?
	let canViewCustomForms : Bool?
	let canMarkResidentTasks : Bool?
	let canManageUsers : Bool?
	let canViewActivities : Bool?
	let canViewVitals : Bool?
	let canViewClinicalInfo : Bool?
	let canViewAppointmentTitleAndDescriptionOnly : Bool?
	let canManageEmar : Bool?
	let canViewFacilityCalendar : Bool?
	let canManageServices : Bool?
	let canManageCollaborators : Bool?
	let canManageCustomForms : Bool?
	let canViewFamilyEngagement : Bool?
	let family : Family?
	let canReportIR : Bool?
	let canAddResidents : Bool?
	let canViewSecureMessaging : Bool?
	let canManageVitals : Bool?
	let rsp : Rsp?
	let canCopyRspConfiguration : Bool?
	let canUpdateFacilityGroups : Bool?
	let canViewAppointmentTitleOnly : Bool?
	let social : Social?
	let canAddEditClinicalInfo : Bool?
	let canViewIncidentReport : Bool?
	let canAddViewVitals : Bool?
	let canManageLocation : Bool?
	let canPrintDocuments : Bool?
	let hasCCIOSApp : Bool?

	enum CodingKeys: String, CodingKey {

		case canViewResidentInfo = "canViewResidentInfo"
		case canPrintEmar = "canPrintEmar"
		case canManageFacilityConfigurations = "canManageFacilityConfigurations"
		case canViewPARDashboard = "canViewPARDashboard"
		case canManagePARDashboard = "canManagePARDashboard"
		case canPrintClinicalInfo = "canPrintClinicalInfo"
		case canViewResidentTasks = "canViewResidentTasks"
		case canViewDocuments = "canViewDocuments"
		case canManageCareTransition = "canManageCareTransition"
		case canAddRemoveLocalStaffFromRemotePatient = "canAddRemoveLocalStaffFromRemotePatient"
		case canManageCPX = "canManageCPX"
		case hasCCMApp = "hasCCMApp"
		case canAccessClinicalTodos = "canAccessClinicalTodos"
		case canManageTodos = "canManageTodos"
		case canAddEditDeleteFacilityCalendar = "canAddEditDeleteFacilityCalendar"
		case canViewAllTodos = "canViewAllTodos"
		case canEditIncidentReport = "canEditIncidentReport"
		case hasNativeStaffApp = "hasNativeStaffApp"
		case canViewSsn = "canViewSsn"
		case clinicalReferral = "ClinicalReferral"
		case canViewManageClinicalInfo = "canViewManageClinicalInfo"
		case canManageAppointments = "canManageAppointments"
		case canTakeEmergencyPrint = "canTakeEmergencyPrint"
		case canManageFacilityGroups = "canManageFacilityGroups"
		case canManageResidentTasks = "canManageResidentTasks"
		case canModifyPharmacySchedule = "canModifyPharmacySchedule"
		case canManageBroadcast = "canManageBroadcast"
		case assessments = "Assessments"
		case canHideTodos = "canHideTodos"
		case canManageTaskSuspensions = "canManageTaskSuspensions"
		case canViewNotes = "canViewNotes"
		case canSaveAndHoldIR = "canSaveAndHoldIR"
		case canManageSocial = "canManageSocial"
		case canViewPatientEngagement = "canViewPatientEngagement"
		case canPrintCustomForms = "canPrintCustomForms"
		case canManageDocuments = "canManageDocuments"
		case hasTodosApp = "hasTodosApp"
		case canViewSocial = "canViewSocial"
		case notes = "Notes"
		case canUpdateOrManageFacilityGroups = "canUpdateOrManageFacilityGroups"
		case canAccessAllTodos = "canAccessAllTodos"
		case hasSharedDocumentsApp = "hasSharedDocumentsApp"
		case canViewTodos = "canViewTodos"
		case canAccessRspTodos = "canAccessRspTodos"
		case canViewCareLocations = "canViewCareLocations"
		case activities2 = "Activities2"
		case canAccessTodos = "canAccessTodos"
		case canViewCareTransition = "canViewCareTransition"
		case canManageFamilyAnnouncements = "canManageFamilyAnnouncements"
		case canManageCCM = "canManageCCM"
		case canViewCustomForms = "canViewCustomForms"
		case canMarkResidentTasks = "canMarkResidentTasks"
		case canManageUsers = "canManageUsers"
		case canViewActivities = "canViewActivities"
		case canViewVitals = "canViewVitals"
		case canViewClinicalInfo = "canViewClinicalInfo"
		case canViewAppointmentTitleAndDescriptionOnly = "canViewAppointmentTitleAndDescriptionOnly"
		case canManageEmar = "canManageEmar"
		case canViewFacilityCalendar = "canViewFacilityCalendar"
		case canManageServices = "canManageServices"
		case canManageCollaborators = "canManageCollaborators"
		case canManageCustomForms = "canManageCustomForms"
		case canViewFamilyEngagement = "canViewFamilyEngagement"
		case family = "Family"
		case canReportIR = "canReportIR"
		case canAddResidents = "canAddResidents"
		case canViewSecureMessaging = "canViewSecureMessaging"
		case canManageVitals = "canManageVitals"
		case rsp = "Rsp"
		case canCopyRspConfiguration = "canCopyRspConfiguration"
		case canUpdateFacilityGroups = "canUpdateFacilityGroups"
		case canViewAppointmentTitleOnly = "canViewAppointmentTitleOnly"
		case social = "Social"
		case canAddEditClinicalInfo = "canAddEditClinicalInfo"
		case canViewIncidentReport = "canViewIncidentReport"
		case canAddViewVitals = "canAddViewVitals"
		case canManageLocation = "canManageLocation"
		case canPrintDocuments = "canPrintDocuments"
		case hasCCIOSApp = "hasCCIOSApp"
	}

}

extension Authorization {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canViewResidentInfo = try values.decodeIfPresent(Bool.self, forKey: .canViewResidentInfo)
        canPrintEmar = try values.decodeIfPresent(Bool.self, forKey: .canPrintEmar)
        canManageFacilityConfigurations = try values.decodeIfPresent(Bool.self, forKey: .canManageFacilityConfigurations)
        canViewPARDashboard = try values.decodeIfPresent(Bool.self, forKey: .canViewPARDashboard)
        canManagePARDashboard = try values.decodeIfPresent(Bool.self, forKey: .canManagePARDashboard)
        canPrintClinicalInfo = try values.decodeIfPresent(Bool.self, forKey: .canPrintClinicalInfo)
        canViewResidentTasks = try values.decodeIfPresent(Bool.self, forKey: .canViewResidentTasks)
        canViewDocuments = try values.decodeIfPresent(Bool.self, forKey: .canViewDocuments)
        canManageCareTransition = try values.decodeIfPresent(Bool.self, forKey: .canManageCareTransition)
        canAddRemoveLocalStaffFromRemotePatient = try values.decodeIfPresent(Bool.self, forKey: .canAddRemoveLocalStaffFromRemotePatient)
        canManageCPX = try values.decodeIfPresent(Bool.self, forKey: .canManageCPX)
        hasCCMApp = try values.decodeIfPresent(Bool.self, forKey: .hasCCMApp)
        canAccessClinicalTodos = try values.decodeIfPresent(Bool.self, forKey: .canAccessClinicalTodos)
        canManageTodos = try values.decodeIfPresent(Bool.self, forKey: .canManageTodos)
        canAddEditDeleteFacilityCalendar = try values.decodeIfPresent(Bool.self, forKey: .canAddEditDeleteFacilityCalendar)
        canViewAllTodos = try values.decodeIfPresent(Bool.self, forKey: .canViewAllTodos)
        canEditIncidentReport = try values.decodeIfPresent(Bool.self, forKey: .canEditIncidentReport)
        hasNativeStaffApp = try values.decodeIfPresent(Bool.self, forKey: .hasNativeStaffApp)
        canViewSsn = try values.decodeIfPresent(Bool.self, forKey: .canViewSsn)
        clinicalReferral = try values.decodeIfPresent(ClinicalReferral.self, forKey: .clinicalReferral)
        canViewManageClinicalInfo = try values.decodeIfPresent(Bool.self, forKey: .canViewManageClinicalInfo)
        canManageAppointments = try values.decodeIfPresent(Bool.self, forKey: .canManageAppointments)
        canTakeEmergencyPrint = try values.decodeIfPresent(Bool.self, forKey: .canTakeEmergencyPrint)
        canManageFacilityGroups = try values.decodeIfPresent(Bool.self, forKey: .canManageFacilityGroups)
        canManageResidentTasks = try values.decodeIfPresent(Bool.self, forKey: .canManageResidentTasks)
        canModifyPharmacySchedule = try values.decodeIfPresent(Bool.self, forKey: .canModifyPharmacySchedule)
        canManageBroadcast = try values.decodeIfPresent(Bool.self, forKey: .canManageBroadcast)
        assessments = try values.decodeIfPresent(Assessments.self, forKey: .assessments)
        canHideTodos = try values.decodeIfPresent(Bool.self, forKey: .canHideTodos)
        canManageTaskSuspensions = try values.decodeIfPresent(Bool.self, forKey: .canManageTaskSuspensions)
        canViewNotes = try values.decodeIfPresent(Bool.self, forKey: .canViewNotes)
        canSaveAndHoldIR = try values.decodeIfPresent(Bool.self, forKey: .canSaveAndHoldIR)
        canManageSocial = try values.decodeIfPresent(Bool.self, forKey: .canManageSocial)
        canViewPatientEngagement = try values.decodeIfPresent(Bool.self, forKey: .canViewPatientEngagement)
        canPrintCustomForms = try values.decodeIfPresent(Bool.self, forKey: .canPrintCustomForms)
        canManageDocuments = try values.decodeIfPresent(Bool.self, forKey: .canManageDocuments)
        hasTodosApp = try values.decodeIfPresent(Bool.self, forKey: .hasTodosApp)
        canViewSocial = try values.decodeIfPresent(Bool.self, forKey: .canViewSocial)
        notes = try values.decodeIfPresent(Notes.self, forKey: .notes)
        canUpdateOrManageFacilityGroups = try values.decodeIfPresent(Bool.self, forKey: .canUpdateOrManageFacilityGroups)
        canAccessAllTodos = try values.decodeIfPresent(Bool.self, forKey: .canAccessAllTodos)
        hasSharedDocumentsApp = try values.decodeIfPresent(Bool.self, forKey: .hasSharedDocumentsApp)
        canViewTodos = try values.decodeIfPresent(Bool.self, forKey: .canViewTodos)
        canAccessRspTodos = try values.decodeIfPresent(Bool.self, forKey: .canAccessRspTodos)
        canViewCareLocations = try values.decodeIfPresent(Bool.self, forKey: .canViewCareLocations)
        activities2 = try values.decodeIfPresent(Activities2.self, forKey: .activities2)
        canAccessTodos = try values.decodeIfPresent(Bool.self, forKey: .canAccessTodos)
        canViewCareTransition = try values.decodeIfPresent(Bool.self, forKey: .canViewCareTransition)
        canManageFamilyAnnouncements = try values.decodeIfPresent(Bool.self, forKey: .canManageFamilyAnnouncements)
        canManageCCM = try values.decodeIfPresent(Bool.self, forKey: .canManageCCM)
        canViewCustomForms = try values.decodeIfPresent(Bool.self, forKey: .canViewCustomForms)
        canMarkResidentTasks = try values.decodeIfPresent(Bool.self, forKey: .canMarkResidentTasks)
        canManageUsers = try values.decodeIfPresent(Bool.self, forKey: .canManageUsers)
        canViewActivities = try values.decodeIfPresent(Bool.self, forKey: .canViewActivities)
        canViewVitals = try values.decodeIfPresent(Bool.self, forKey: .canViewVitals)
        canViewClinicalInfo = try values.decodeIfPresent(Bool.self, forKey: .canViewClinicalInfo)
        canViewAppointmentTitleAndDescriptionOnly = try values.decodeIfPresent(Bool.self, forKey: .canViewAppointmentTitleAndDescriptionOnly)
        canManageEmar = try values.decodeIfPresent(Bool.self, forKey: .canManageEmar)
        canViewFacilityCalendar = try values.decodeIfPresent(Bool.self, forKey: .canViewFacilityCalendar)
        canManageServices = try values.decodeIfPresent(Bool.self, forKey: .canManageServices)
        canManageCollaborators = try values.decodeIfPresent(Bool.self, forKey: .canManageCollaborators)
        canManageCustomForms = try values.decodeIfPresent(Bool.self, forKey: .canManageCustomForms)
        canViewFamilyEngagement = try values.decodeIfPresent(Bool.self, forKey: .canViewFamilyEngagement)
        family = try values.decodeIfPresent(Family.self, forKey: .family)
        canReportIR = try values.decodeIfPresent(Bool.self, forKey: .canReportIR)
        canAddResidents = try values.decodeIfPresent(Bool.self, forKey: .canAddResidents)
        canViewSecureMessaging = try values.decodeIfPresent(Bool.self, forKey: .canViewSecureMessaging)
        canManageVitals = try values.decodeIfPresent(Bool.self, forKey: .canManageVitals)
        rsp = try values.decodeIfPresent(Rsp.self, forKey: .rsp)
        canCopyRspConfiguration = try values.decodeIfPresent(Bool.self, forKey: .canCopyRspConfiguration)
        canUpdateFacilityGroups = try values.decodeIfPresent(Bool.self, forKey: .canUpdateFacilityGroups)
        canViewAppointmentTitleOnly = try values.decodeIfPresent(Bool.self, forKey: .canViewAppointmentTitleOnly)
        social = try values.decodeIfPresent(Social.self, forKey: .social)
        canAddEditClinicalInfo = try values.decodeIfPresent(Bool.self, forKey: .canAddEditClinicalInfo)
        canViewIncidentReport = try values.decodeIfPresent(Bool.self, forKey: .canViewIncidentReport)
        canAddViewVitals = try values.decodeIfPresent(Bool.self, forKey: .canAddViewVitals)
        canManageLocation = try values.decodeIfPresent(Bool.self, forKey: .canManageLocation)
        canPrintDocuments = try values.decodeIfPresent(Bool.self, forKey: .canPrintDocuments)
        hasCCIOSApp = try values.decodeIfPresent(Bool.self, forKey: .hasCCIOSApp)
    }

}
