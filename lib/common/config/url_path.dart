class UrlPath {
  final String getMe;
  final String signUp;
  final String signIn;
  final String signOut;
  final String validateEmail;
  final String getToken;
  final String incidents;
  final String bookmarks;
  final String getOTP;
  final String getConfig;
  final String uploadProfilePicture;
  final String feedbacks;
  final String deleteUser;
  final String updateUser;
  final String getNotifications;
  final String trackEvent;
  final String log;
  final String attributions;
  final String getTermsOfUse;
  final String getPrivacyPolicy;
  final String getFAQ;
  final String updateFCMToken;
  final String tcAgree;
  final String source;

  //static const String _DEV_BASE_URL = 'https://justrade-api-dev.chellobee.com/';
  //static const String _DEV_BASE_URL = 'http://192.168.29.73:6000/';
  static const String _DEV_BASE_URL = 'https://7pqusc5040.execute-api.ap-south-1.amazonaws.com/dev/';
  //static const String _DEV_BASE_URL = 'https://b1kulr5exd.execute-api.ap-south-1.amazonaws.com/dev/';
  static const String _PRODUCTION_BASE_URL = 'https://justrade-api.chellobee.com/';

  const UrlPath.dev({
    this.getMe = _DEV_BASE_URL + 'v1/me',
    this.signUp = _DEV_BASE_URL + 'v1/signup',
    this.signIn = _DEV_BASE_URL + 'v1/signin',
    this.signOut = _DEV_BASE_URL + 'v1/signout?notification=%s',
    this.validateEmail = _DEV_BASE_URL + 'v1/validate',
    this.getToken = _DEV_BASE_URL + 'v1/token',
    this.incidents = _DEV_BASE_URL + 'v1/incidents',
    this.bookmarks = _DEV_BASE_URL + 'v1/bookmarks',
    this.getOTP = _DEV_BASE_URL + 'v1/otp',
    this.getConfig = _DEV_BASE_URL + 'v1/config',
    this.uploadProfilePicture = _DEV_BASE_URL + 'v1/profilepic',
    this.feedbacks = _DEV_BASE_URL + 'v1/feedbacks',
    this.deleteUser = _DEV_BASE_URL + 'v1/delete',
    this.updateUser = _DEV_BASE_URL + 'v1/update',
    this.getNotifications = _DEV_BASE_URL + 'v1/notifications',
    this.trackEvent = _DEV_BASE_URL + 'v1/events',
    this.log = _DEV_BASE_URL + 'v1/logs',
    this.attributions = _DEV_BASE_URL + 'v1/attributions',
    this.getTermsOfUse = _DEV_BASE_URL + 'v1/termsofuse',
    this.getPrivacyPolicy = _DEV_BASE_URL + 'v1/privacypolicy',
    this.getFAQ = _DEV_BASE_URL + 'v1/faq',
    this.updateFCMToken = _DEV_BASE_URL + 'v1/fcm/token',
    this.tcAgree = _DEV_BASE_URL + 'v1/tc/agree/%s',
    this.source = _DEV_BASE_URL + 'v1/source',
  });

  const UrlPath.production({
    this.getMe = _PRODUCTION_BASE_URL + 'v1/me',
    this.signUp = _PRODUCTION_BASE_URL + 'v1/signup',
    this.signIn = _PRODUCTION_BASE_URL + 'v1/signin',
    this.signOut = _PRODUCTION_BASE_URL + 'v1/signout?notification=%s',
    this.validateEmail = _PRODUCTION_BASE_URL + 'v1/validate',
    this.getToken = _PRODUCTION_BASE_URL + 'v1/token',
    this.incidents = _PRODUCTION_BASE_URL + 'v1/incidents',
    this.bookmarks = _PRODUCTION_BASE_URL + 'v1/bookmarks',
    this.getOTP = _PRODUCTION_BASE_URL + 'v1/otp',
    this.getConfig = _PRODUCTION_BASE_URL + 'v1/config',
    this.uploadProfilePicture = _PRODUCTION_BASE_URL + 'v1/profilepic',
    this.feedbacks = _PRODUCTION_BASE_URL + 'v1/feedbacks',
    this.deleteUser = _PRODUCTION_BASE_URL + 'v1/delete',
    this.updateUser = _PRODUCTION_BASE_URL + 'v1/update',
    this.getNotifications = _PRODUCTION_BASE_URL + 'v1/notifications',
    this.trackEvent = _PRODUCTION_BASE_URL + 'v1/events',
    this.log = _PRODUCTION_BASE_URL + 'v1/logs',
    this.attributions = _PRODUCTION_BASE_URL + 'v1/attributions',
    this.getTermsOfUse = _PRODUCTION_BASE_URL + 'v1/termsofuse',
    this.getPrivacyPolicy = _PRODUCTION_BASE_URL + 'v1/privacypolicy',
    this.getFAQ = _PRODUCTION_BASE_URL + 'v1/faq',
    this.updateFCMToken = _PRODUCTION_BASE_URL + 'v1/fcm/token',
    this.tcAgree = _PRODUCTION_BASE_URL + 'v1/tc/agree/%s',
    this.source = _PRODUCTION_BASE_URL + 'v1/source',
  });
}
