class DataList {
  List<Data> data;

  DataList({this.data});

  DataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  int index;
  String title;
  String picture;

  Data({this.sId, this.index, this.title, this.picture});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    index = json['index'];
    title = json['title'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['index'] = this.index;
    data['title'] = this.title;
    data['picture'] = this.picture;
    return data;
  }
}
