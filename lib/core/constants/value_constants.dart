// ignore_for_file: constant_identifier_names

const Duration VALUE_RESEND_OTP_WAIT_DURATION = Duration(seconds: 60);
const double VALUE_STANDARD_SCREEN_PADDING = 16;
const double VALUE_ACTION_PRIMARY_BUTTON_WIDTH = 296;
const double VALUE_ACTION_PRIMARY_BUTTON_HEIGHT = 60;
const int VALUE_TOAST_DURATION_SHORT = 2;
const int VALUE_TOAST_DURATION_MEDIUM = 3;
const int VALUE_TOAST_DURATION_LONG = 5;
const Duration VALUE_SNACK_BAR_DURATION = Duration(seconds: 5);

//==========================================================
// Corner Radius
const double VALUE_ACTION_BUTTON_CORNERRAIUS = 10;
const double VALUE_AVATAR_ICON_CORNER_RADIUS = 10;
const double VALUE_BOX_BUTTON_CORNER_RADIUS = 10;
const double VALUE_PRIMARY_BUTTON_CORNER_RADIUS = 8;
const double VALUE_STANDARD_BUTTON_CORNER_RADIUS = 4;
const double HEADER_CARD_BORDER_RADIUS = 12;
const double VALUE_TABBAR_BORDER_RADIUS = 0;
const double VALUE_ICONTITLESUBTITLE_BORDER_RADIUS = 10;
const double VALUE_BORDER_RADIUS_4 = 4.0;
const double VALUE_CARD_CONTAINER_BORDER_RADIUS = 10;
const double VALUE_DRAWER_BORDER_RADIUS = 20;

//==========================================================
// Width
const double VALUE_TAB_BAR_LINE_WIDTH = 2;
const double VALUE_ACTION_PROFILE_PIC_WIDTH = 100;
const double VALUE_ACTION_PRIMARY_BUTTON_TYPE_3_WIDTH = 169;
const double VALUE_PRIMARY_LOGO_WIDTH = 148.0;
const double VALUE_FIGMA_DESIGN_WIDTH = 375.0;
const double VALUE_LEAD_INSURANCE_CARD_WIDTH = 312.0;

//==========================================================
// Height
const double VALUE_TAB_BAR_HEIGHT = 30;
const double VALUE_BOX_BUTTON_HEIGHT = 48;
const double VALUE_ACTION_PROFILE_PIC_HEIGHT = 100;
const double VALUE_ACTION_PRIMARY_BUTTON_TYPE_3_HEIGHT = 36;
const double VALUE_PRIMARY_LOGO_HEIGHT = 27.22;
const double VALUE_FIGMA_DESIGN_HEIGHT = 812.0;
const double VALUE_LEAD_INSURANCE_CARD_HEIGHT = 232.0;

//==========================================================
enum ToastType { Information, Alert, Error, Success }

enum ToastDuration { short, medium, long }

enum ImageShapes {
  None,
  Standard, // Corners will not be sharp
  Square,
  Top, // Sharp corners
  File // From a file path
}


