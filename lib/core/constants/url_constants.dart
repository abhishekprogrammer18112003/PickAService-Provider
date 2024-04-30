// ignore_for_file: constant_identifier_names, unnecessary_brace_in_string_interps

  const String BASE_URL = "https://live.pickaservice.com";

//=====================Auth Api's ===========================
const String LOGIN = "${BASE_URL}/api/auth/webLogin";

//==================== Notification Api's =====================

const String GETNOTIFICATION = "${BASE_URL}/api/tickets/getNotificationById";
const String ACCEPTORDER = "${BASE_URL}/api/tickets/UpdateOrderStatus";
const String DECLINEORDER = "${BASE_URL}/api/tickets/declineOrders";

const String GETTICKETDETAILS = "${BASE_URL}/api/tickets/getTicketByTicketId";

//======================Home Page ==========================

const String GETACCEPTEDORDERS = "${BASE_URL}/api/tickets/listAcceptedOrders";

//================== SCHEDULE HISTORY PAGE ==============================

const String GETUPCOMINGTICKETS = "${BASE_URL}/api/tickets/upcoming";

const String FILTERCOMPLETEDTASK = "${BASE_URL}/api/tickets/completedTickets";

// ================ LOCATION API================================

const String POSTLOCATION =
    "${BASE_URL}/api/technician/updateTechniciansLocation";

//=================== CHECK LIST ======================================
const String GETTONS = "${BASE_URL}/api/checklist/getSubSubCat";

const String GETTONSMODEL = "${BASE_URL}/api/checklist/getSubCategoryModel";

const String CREATECHECKLIST =
    "${BASE_URL}/api/checklist/createChecklistFileUpload";
const String GETINVOICELIST = "${BASE_URL}/api/checklist/getPriceListByModelId";
const String VIEWINVOICE =
    "${BASE_URL}/api/invoice/getInvoiceItemsByInvoiceId";

const String SEARCHINVOICEPRICE = "${BASE_URL}/api/invoice/getInvoiceItems";
const String CREATEINVOICE = "${BASE_URL}/api/invoice/createInvoice";
const String GETCHECKLIST =
    "${BASE_URL}/api/checklist/getChecklistByChecklistId";

const String COMPLETED = "${BASE_URL}/api/tickets/completedTickets";
const String OFFLINEPAYMENT = "${BASE_URL}/api/payment/offline";

//====================== PROFILE ============================================

const String PERSONALDATA = "${BASE_URL}/api/profile/getProfileDataUsingId";

const String EDITPROFILE = "${BASE_URL}/api/profile/updateUserProfile";
const String GETOTP = "${BASE_URL}/api/profile/updatePhone";
const String CHANGEPASSWORD = "${BASE_URL}/api/profile/updateUserProfile";


