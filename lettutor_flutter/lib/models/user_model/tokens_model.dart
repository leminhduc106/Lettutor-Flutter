class Tokens {
  late Access access;
  late Access refresh;

  Tokens({required this.access, required this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access = Access.fromJson(json['access']);
    refresh = Access.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['access'] = access.toJson();
    data['refresh'] = refresh.toJson();
    return data;
  }
}

class Access {
  late String token;
  late String expires;

  Access({required this.token, required this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = token;
    data['expires'] = expires;
    return data;
  }
}
