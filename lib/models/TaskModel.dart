class Task {
  String? sId;
  String? userId;
  String? title;
  String? description;
  int? lng;
  String? attachment;
  String? completeBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Task(
      {this.sId,
        this.userId,
        this.title,
        this.description,
        this.lng,
        this.attachment,
        this.completeBy,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Task.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    lng = json['lng'];
    attachment = json['attachment'];
    completeBy = json['completeBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['lng'] = this.lng;
    data['attachment'] = this.attachment;
    data['completeBy'] = this.completeBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

