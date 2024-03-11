import 'dart:io';

class User {
  String? id;
  int? credit;
  String? otp;
  String? fullName;
  String? dob;
  String? email;
  String? phoneNo;
  String? provider;
  File? profilePicture;
  String? profilePictureUrl;
  int? otpElapsedTimeInSeconds = 0;
  String? countryISOCode;
  String? referralCode;
  String? referredCode;
  int? isVerified;
  num? rating;
  int? ratingCount;
  int? isAuthenticated;
  int unreadNotificationCount = 0;
  int? referredCount;
  String? latestTCVersion;
  String? source;
  String? idToken;
  bool? isPhoneVerified;
  bool? isIdentityVerified;
  Set<String> bookmarks = {};
  int unreadMessagesCount = 0;
  List<Device> devices = [];
  Device device = Device();
  Set<String> blockedUsers = {};

  User({
    this.id,
    this.credit,
    this.otp,
    this.fullName,
    this.email,
    this.phoneNo,
    this.provider,
    this.profilePicture,
    this.profilePictureUrl,
    this.otpElapsedTimeInSeconds,
    this.countryISOCode,
    this.idToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    credit = json['coins'];
    otp = json['otp'];
    fullName = json['fullName'];
    dob = json['dob'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    provider = json['provider'];
    profilePictureUrl = json['profilePictureUrl'];
    otpElapsedTimeInSeconds = json['otpElapsedTimeInSeconds'];
    countryISOCode = json['countryISOCode'];
    referralCode = json['referralCode'];
    referredCode = json['referredCode'];
    isVerified = json['isVerified'];
    isAuthenticated = json['isAuthenticated'] ?? 0;
    referredCount = json['referredCount'] ?? 0;
    latestTCVersion = json['latestTCVersion'];
    source = json['source'];
    idToken = json['idToken'];
    isPhoneVerified = json['isPhoneVerified'] ?? false;
    isIdentityVerified = json['isIdentityVerified'] ?? false;
    bookmarks = json.containsKey('bookmarks') ? {...json['bookmarks'].cast<String>()} : {};
    rating = json['rating'] ?? 0.0;
    ratingCount = json['ratingCount'] ?? 0;
    unreadNotificationCount = json['unreadNotificationCount'] ?? 0;
    unreadMessagesCount = json['unreadMessagesCount'] ?? 0;
    device = json['device'] != null ? Device.fromJson(json['device']) : Device();
    blockedUsers = json.containsKey('blockedUsers') ? {...json['blockedUsers'].cast<String>()} : {};
    if (json['devices'] != null) {
      json['devices'].forEach((v) {
        devices.add(Device.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['coins'] = credit;
    data['otp'] = otp;
    data['fullName'] = fullName;
    data['dob'] = dob;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['profilePictureUrl'] = profilePictureUrl;
    data['provider'] = provider;
    data['countryISOCode'] = countryISOCode;
    data['otpElapsedTimeInSeconds'] = otpElapsedTimeInSeconds;
    data['referralCode'] = referralCode;
    data['referredCode'] = referredCode;
    data['isVerified'] = isVerified;
    data['isAuthenticated'] = isAuthenticated;
    data['unreadNotificationCount'] = unreadNotificationCount;
    data['referredCount'] = referredCount;
    data['latestTCVersion'] = latestTCVersion;
    data['source'] = source;
    data['devices'] = devices;
    data['device'] = device;
    data['bookmarks'] = bookmarks.toList();
    data['blockedUsers'] = blockedUsers.toList();
    return data;
  }

  bool isAdmin() {
    return email != null && email == 'admin@chellobee.com';
  }
}

class Device {
  String? deviceId;
  String? deviceName;
  String? fcmToken;
  Preferences preferences = Preferences();

  Device({this.deviceId, this.fcmToken, Preferences? preferences});

  Device.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    fcmToken = json['fcmToken'];
    preferences = json['preferences'] != null ? Preferences.fromJson(json['preferences']) : Preferences();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['deviceName'] = deviceName;
    data['fcmToken'] = fcmToken;
    data['preferences'] = preferences;

    if (deviceId == null) data.remove('deviceId');
    if (deviceName == null) data.remove('deviceName');
    if (fcmToken == null) data.remove('fcmToken');
    return data;
  }
}

class Preferences {
  Notifications notifications = Notifications();
  String language = 'en';
  int theme = 1;

  Preferences({this.language = 'en', this.theme = 1});

  Preferences.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null ? Notifications.fromJson(json['notifications']) : Notifications();
    language = json['language'] ?? 'en';
    theme = json['theme'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notifications'] = notifications;
    data['language'] = language;
    data['theme'] = theme;
    return data;
  }
}

class Notifications {
  bool enabled = false;
  bool newProduct = false;
  bool chat = false;
  bool approval = false;

  Notifications({this.enabled = false, this.newProduct = false, this.chat = false, this.approval = false});

  Notifications.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'] ?? false;
    newProduct = json['newProduct'] ?? false;
    chat = json['chat'] ?? false;
    approval = json['approval'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['newProduct'] = newProduct;
    data['chat'] = chat;
    data['approval'] = approval;
    return data;
  }
}
