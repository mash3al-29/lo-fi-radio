class shareLinkModel {
  String sharedLink;

  shareLinkModel({
    this.sharedLink,
  });

  shareLinkModel.fromJson(Map<String, dynamic> json) {
    sharedLink = json['sharedLink'];
  }

  Map<String, dynamic> ToMap() {
    return {
      'sharedLink': sharedLink,
    };
  }
}
