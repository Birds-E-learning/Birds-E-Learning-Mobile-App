class GetCoursesResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  GetCoursesResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetCoursesResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as Map<String, dynamic>?) != null
        ? ResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
        : null;
  }
}

class ResponseData {
  List<Category>? categories;

  ResponseData({
    this.categories,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    categories = (json['categories'] as List?)
        ?.map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Category {
  String? id;
  String? name;
  dynamic imageId;
  String? content;
  String? slug;
  String? status;
  dynamic lft;
  dynamic rgt;
  dynamic parentId;
  dynamic createUser;
  dynamic updateUser;
  dynamic deletedAt;
  dynamic originId;
  dynamic lang;
  String? createdAt;
  String? updatedAt;
  List<Courses>? courses;

  Category({
    this.id,
    this.name,
    this.imageId,
    this.content,
    this.slug,
    this.status,
    this.lft,
    this.rgt,
    this.parentId,
    this.createUser,
    this.updateUser,
    this.deletedAt,
    this.originId,
    this.lang,
    this.createdAt,
    this.updatedAt,
    this.courses,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    imageId = json['imageId'] as dynamic;
    content = json['content'] as String?;
    slug = json['slug'] as String?;
    status = json['status'] as String?;
    lft = json['_lft'] as dynamic;
    rgt = json['_rgt'] as dynamic;
    parentId = json['parentId'];
    createUser = json['createUser'];
    updateUser = json['updateUser'];
    deletedAt = json['deletedAt'];
    originId = json['originId'];
    lang = json['lang'];
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    courses = (json['courses'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class Courses {
  dynamic progress;
  String? id;
  String? title;
  String? slug;
  String? content;
  dynamic imageId;
  dynamic bannerImageId;
  String? shortDesc;
  dynamic categoryId;
  dynamic isFeatured;
  String? gallery;
  String? video;
  String? price;
  String? salePrice;
  dynamic duration;
  dynamic faqs;
  String? status;
  dynamic publishDate;
  String? createUser;
  String? updateUser;
  dynamic deletedAt;
  String? views;
  String? createdAt;
  String? updatedAt;
  dynamic defaultState;
  dynamic reviewScore;
  dynamic include;
  dynamic exclude;
  dynamic itinerary;
  String? imageUrl;
  String? imageBannerUrl;
  bool? wishList;
  Facilitator? facilitator;
  List<Sections>? sections;

  Courses({
    this.progress,
    this.id,
    this.title,
    this.slug,
    this.content,
    this.imageId,
    this.bannerImageId,
    this.shortDesc,
    this.categoryId,
    this.isFeatured,
    this.gallery,
    this.video,
    this.price,
    this.salePrice,
    this.duration,
    this.faqs,
    this.status,
    this.publishDate,
    this.createUser,
    this.updateUser,
    this.deletedAt,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.defaultState,
    this.reviewScore,
    this.include,
    this.exclude,
    this.itinerary,
    this.imageUrl,
    this.imageBannerUrl,
    this.wishList,
    this.facilitator,
    this.sections,
  });

  Courses.fromJson(Map<String, dynamic> json) {
    progress = json['progress'] as dynamic;
    id = json['id'] as String?;
    title = json['title'] as String?;
    slug = json['slug'] as String?;
    content = json['content'] as String?;
    imageId = json['imageId'] as dynamic;
    bannerImageId = json['bannerImageId'] as dynamic;
    shortDesc = json['shortDesc'] as String?;
    categoryId = json['categoryId'] as dynamic;
    isFeatured = json['isFeatured'] as dynamic;
    gallery = json['gallery'] as String?;
    video = json['video'] as String?;
    price = json['price'] as String?;
    salePrice = json['salePrice'] as String?;
    duration = json['duration'] as dynamic;
    faqs = json['faqs'];
    status = json['status'] as String?;
    publishDate = json['publishDate'];
    createUser = json['createUser'] as String?;
    updateUser = json['updateUser'] as String?;
    deletedAt = json['deletedAt'];
    views = json['views'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    defaultState = json['defaultState'] as dynamic;
    reviewScore = json['reviewScore'];
    include = json['include'];
    exclude = json['exclude'];
    itinerary = json['itinerary'];
    imageUrl = json['imageUrl'] as String?;
    imageBannerUrl = json['imageBannerUrl'] as String?;
    wishList = json['wishList'] as bool?;
    facilitator = (json['facilitator'] as Map<String, dynamic>?) != null
        ? Facilitator.fromJson(json['facilitator'] as Map<String, dynamic>)
        : null;
    sections = (json['sections'] as List?)
        ?.map((dynamic e) => Sections.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['progress'] = progress;
    json['id'] = id;
    json['title'] = title;
    json['slug'] = slug;
    json['content'] = content;
    json['imageId'] = imageId;
    json['bannerImageId'] = bannerImageId;
    json['shortDesc'] = shortDesc;
    json['categoryId'] = categoryId;
    json['isFeatured'] = isFeatured;
    json['gallery'] = gallery;
    json['video'] = video;
    json['price'] = price;
    json['salePrice'] = salePrice;
    json['duration'] = duration;
    json['faqs'] = faqs;
    json['status'] = status;
    json['publishDate'] = publishDate;
    json['createUser'] = createUser;
    json['updateUser'] = updateUser;
    json['deletedAt'] = deletedAt;
    json['views'] = views;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['defaultState'] = defaultState;
    json['reviewScore'] = reviewScore;
    json['include'] = include;
    json['exclude'] = exclude;
    json['itinerary'] = itinerary;
    json['imageUrl'] = imageUrl;
    json['imageBannerUrl'] = imageBannerUrl;
    json['wishList'] = wishList;
    json['facilitator'] = facilitator?.toJson();
    json['sections'] = sections?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Facilitator {
  dynamic courses;
  String? id;
  String? email;
  String? name;
  String? degree;
  String? skill;
  dynamic reviews;
  dynamic ratings;
  dynamic students;
  String? imageUrl;

  Facilitator({
    this.courses,
    this.id,
    this.email,
    this.name,
    this.degree,
    this.skill,
    this.reviews,
    this.ratings,
    this.students,
    this.imageUrl,
  });

  Facilitator.fromJson(Map<String, dynamic> json) {
    courses = json['courses'] as dynamic;
    id = json['id'] as String?;
    email = json['email'] as String?;
    name = json['name'] as String?;
    degree = json['degree'] as String?;
    skill = json['skill'] as String?;
    reviews = json['reviews'] as dynamic;
    ratings = json['ratings'] as dynamic;
    students = json['students'] as dynamic;
    imageUrl = json['imageUrl'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['courses'] = courses;
    json['id'] = id;
    json['email'] = email;
    json['name'] = name;
    json['degree'] = degree;
    json['skill'] = skill;
    json['reviews'] = reviews;
    json['ratings'] = ratings;
    json['students'] = students;
    json['imageUrl'] = imageUrl;
    return json;
  }
}

class Sections {
  String? id;
  dynamic courseId;
  String? name;
  String? slug;
  String? service;
  dynamic displayType;
  dynamic hideInSingle;
  dynamic active;
  dynamic displayOrder;
  dynamic createUser;
  dynamic updateUser;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Lessons>? lessons;

  Sections({
    this.id,
    this.courseId,
    this.name,
    this.slug,
    this.service,
    this.displayType,
    this.hideInSingle,
    this.active,
    this.displayOrder,
    this.createUser,
    this.updateUser,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lessons,
  });

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    courseId = json['courseId'] as dynamic;
    name = json['name'] as String?;
    slug = json['slug'] as String?;
    service = json['service'] as String?;
    displayType = json['displayType'];
    hideInSingle = json['hideInSingle'];
    active = json['active'] as dynamic;
    displayOrder = json['displayOrder'] as dynamic;
    createUser = json['createUser'];
    updateUser = json['updateUser'];
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    deletedAt = json['deletedAt'];
    lessons = (json['lessons'] as List?)
        ?.map((dynamic e) => Lessons.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['courseId'] = courseId;
    json['name'] = name;
    json['slug'] = slug;
    json['service'] = service;
    json['displayType'] = displayType;
    json['hideInSingle'] = hideInSingle;
    json['active'] = active;
    json['displayOrder'] = displayOrder;
    json['createUser'] = createUser;
    json['updateUser'] = updateUser;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['deletedAt'] = deletedAt;
    json['lessons'] = lessons?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Lessons {
  String? id;
  dynamic sectionId;
  dynamic courseId;
  String? name;
  dynamic content;
  dynamic shortDesc;
  dynamic duration;
  String? slug;
  dynamic fileId;
  String? type;
  String? url;
  String? previewUrl;
  dynamic active;
  dynamic displayOrder;
  dynamic originId;
  dynamic language;
  dynamic createUser;
  dynamic updateUser;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic imageId;
  dynamic icon;

  Lessons({
    this.id,
    this.sectionId,
    this.courseId,
    this.name,
    this.content,
    this.shortDesc,
    this.duration,
    this.slug,
    this.fileId,
    this.type,
    this.url,
    this.previewUrl,
    this.active,
    this.displayOrder,
    this.originId,
    this.language,
    this.createUser,
    this.updateUser,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageId,
    this.icon,
  });

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    sectionId = json['sectionId'] as dynamic;
    courseId = json['courseId'] as dynamic;
    name = json['name'] as String?;
    content = json['content'];
    shortDesc = json['shortDesc'];
    duration = json['duration'] as dynamic;
    slug = json['slug'] as String?;
    fileId = json['fileId'];
    type = json['type'] as String?;
    url = json['url'] as String?;
    previewUrl = json['previewUrl'] as String?;
    active = json['active'] as dynamic;
    displayOrder = json['displayOrder'] as dynamic;
    originId = json['originId'];
    language = json['language'];
    createUser = json['createUser'];
    updateUser = json['updateUser'];
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    deletedAt = json['deletedAt'];
    imageId = json['imageId'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['sectionId'] = sectionId;
    json['courseId'] = courseId;
    json['name'] = name;
    json['content'] = content;
    json['shortDesc'] = shortDesc;
    json['duration'] = duration;
    json['slug'] = slug;
    json['fileId'] = fileId;
    json['type'] = type;
    json['url'] = url;
    json['previewUrl'] = previewUrl;
    json['active'] = active;
    json['displayOrder'] = displayOrder;
    json['originId'] = originId;
    json['language'] = language;
    json['createUser'] = createUser;
    json['updateUser'] = updateUser;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['deletedAt'] = deletedAt;
    json['imageId'] = imageId;
    json['icon'] = icon;
    return json;
  }
}
