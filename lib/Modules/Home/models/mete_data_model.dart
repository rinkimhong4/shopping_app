// To parse this JSON data, do
//
//     final hypeWear = hypeWearFromJson(jsonString);

import 'dart:convert';

HypeWearMetaData hypeWearFromJson(String str) {
  final jsonData = json.decode(str);
  return HypeWearMetaData.fromJson(jsonData);
}

// String hypeWearToJson(HypeWear data) {
//   final dyn = data.toJson();
//   return json.encode(dyn);
// }

class HypeWearMetaData {
  AboutUs? aboutUs;
  TermsAndConditions? termsAndConditions;
  CustomerSupport? customerSupport;

  HypeWearMetaData({
    this.aboutUs,
    this.termsAndConditions,
    this.customerSupport,
  });

  factory HypeWearMetaData.fromJson(Map<String, dynamic> json) =>
      HypeWearMetaData(
        aboutUs: AboutUs.fromJson(json["about_us"]),
        termsAndConditions: TermsAndConditions.fromJson(
          json["terms_and_conditions"],
        ),
        customerSupport: CustomerSupport.fromJson(json["customer_support"]),
      );
}

class AboutUs {
  String? title;
  String? content;
  List<String>? whyChooseUs;
  String? closing;

  AboutUs({this.title, this.content, this.whyChooseUs, this.closing});

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
    title: json["title"],
    content: json["content"],
    whyChooseUs: List<String>.from(json["why_choose_us"].map((x) => x)),
    closing: json["closing"],
  );
}

class CustomerSupport {
  String? title;
  String? introduction;
  ContactMethods? contactMethods;
  List<String>? supportTopics;
  String? responseTime;

  CustomerSupport({
    this.title,
    this.introduction,
    this.contactMethods,
    this.supportTopics,
    this.responseTime,
  });

  factory CustomerSupport.fromJson(Map<String, dynamic> json) =>
      CustomerSupport(
        title: json["title"],
        introduction: json["introduction"],
        contactMethods: ContactMethods.fromJson(json["contact_methods"]),
        supportTopics: List<String>.from(json["support_topics"].map((x) => x)),
        responseTime: json["response_time"],
      );
}

class ContactMethods {
  String? email;
  String? phone;
  String? liveChat;

  ContactMethods({this.email, this.phone, this.liveChat});

  factory ContactMethods.fromJson(Map<String, dynamic> json) => ContactMethods(
    email: json["email"],
    phone: json["phone"],
    liveChat: json["live_chat"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "live_chat": liveChat,
  };
}

class TermsAndConditions {
  String? title;
  List<Section>? sections;

  TermsAndConditions({this.title, this.sections});

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) =>
      TermsAndConditions(
        title: json["title"],
        sections: List<Section>.from(
          json["sections"].map((x) => Section.fromJson(x)),
        ),
      );
}

class Section {
  String? title;
  String? content;

  Section({this.title, this.content});

  factory Section.fromJson(Map<String, dynamic> json) =>
      Section(title: json["title"], content: json["content"]);

  Map<String, dynamic> toJson() => {"title": title, "content": content};
}
