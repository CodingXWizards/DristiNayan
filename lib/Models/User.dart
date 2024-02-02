/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class AuthToken {
    User? user;
    String? authToken;

    AuthToken({this.user, this.authToken}); 

    AuthToken.fromJson(Map<String, dynamic> json) {
        user = json['user'] != null ? User?.fromJson(json['user']) : null;
        authToken = json['authToken'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['user'] = user!.toJson();
        data['authToken'] = authToken;
        return data;
    }
}

class User {
    String? name;
    String? userID;
    String? phone;

    User({this.name, this.userID, this.phone}); 

    User.fromJson(Map<String, dynamic> json) {
        name = json['Name'];
        userID = json['UserID'];
        phone = json['Phone'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['Name'] = name;
        data['UserID'] = userID;
        data['Phone'] = phone;
        return data;
    }
}

