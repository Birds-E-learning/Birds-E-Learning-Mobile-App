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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseCode'] = responseCode;
    json['responseMessage'] = responseMessage;
    json['responseData'] = responseData?.toJson();
    return json;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['categories'] = categories?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Category {
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
  String? deletedAt;
  dynamic originId;
  String? lang;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  List<Courses>? courses;

  Category({
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
    this.imageUrl,
    this.courses,
  });

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    imageId = json['imageId'] as dynamic;
    content = json['content'] as String?;
    slug = json['slug'] as String?;
    status = json['status'] as String?;
    lft = json['_lft'] as dynamic;
    rgt = json['_rgt'] as dynamic;
    parentId = json['parentId'] as dynamic;
    createUser = json['createUser'] as dynamic;
    updateUser = json['updateUser'] as dynamic;
    deletedAt = json['deletedAt'] as String?;
    originId = json['originId'] as dynamic;
    lang = json['lang'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    imageUrl = json['imageUrl'] as String?;
    courses = (json['courses'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['imageId'] = imageId;
    json['content'] = content;
    json['slug'] = slug;
    json['status'] = status;
    json['_lft'] = lft;
    json['_rgt'] = rgt;
    json['parentId'] = parentId;
    json['createUser'] = createUser;
    json['updateUser'] = updateUser;
    json['deletedAt'] = deletedAt;
    json['originId'] = originId;
    json['lang'] = lang;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['imageUrl'] = imageUrl;
    json['courses'] = courses?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Courses {
  String? title;
  String? slug;
  String? content;
  dynamic imageId;
  dynamic bannerImageId;
  String? shortDesc;
  dynamic categoryId;
  bool? isFeatured;
  String? gallery;
  String? video;
  dynamic price;
  String? salePrice;
  dynamic duration;
  String? faqs;
  String? status;
  String? publishDate;
  dynamic createUser;
  dynamic updateUser;
  String? deletedAt;
  dynamic views;
  String? createdAt;
  String? updatedAt;
  dynamic defaultState;
  dynamic reviewScore;
  String? include;
  String? exclude;
  String? itinerary;
  String? imageUrl;
  String? imageBannerUrl;
  List<Sections>? sections;
  Facilitator? facilitator;

  Courses({
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
    this.sections,
    this.facilitator,
  });

  Courses.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    slug = json['slug'] as String?;
    content = json['content'] as String?;
    imageId = json['imageId'] as dynamic;
    bannerImageId = json['bannerImageId'] as dynamic;
    shortDesc = json['shortDesc'] as String?;
    categoryId = json['categoryId'] as dynamic;
    isFeatured = json['isFeatured'] as bool?;
    gallery = json['gallery'] as String?;
    video = json['video'] as String?;
    price = json['price'] as dynamic;
    salePrice = json['salePrice'] as String?;
    duration = json['duration'] as dynamic;
    faqs = json['faqs'] as String?;
    status = json['status'] as String?;
    publishDate = json['publishDate'] as String?;
    createUser = json['createUser'] as dynamic;
    updateUser = json['updateUser'] as dynamic;
    deletedAt = json['deletedAt'] as String?;
    views = json['views'] as dynamic;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    defaultState = json['defaultState'] as dynamic;
    reviewScore = json['reviewScore'] as dynamic;
    include = json['include'] as String?;
    exclude = json['exclude'] as String?;
    itinerary = json['itinerary'] as String?;
    imageUrl = json['imageUrl'] as String?;
    imageBannerUrl = json['imageBannerUrl'] as String?;
    sections = (json['sections'] as List?)
        ?.map((dynamic e) => Sections.fromJson(e as Map<String, dynamic>))
        .toList();
    facilitator = (json['facilitator'] as Map<String, dynamic>?) != null
        ? Facilitator.fromJson(json['facilitator'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
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
    json['sections'] = sections?.map((e) => e.toJson()).toList();
    json['facilitator'] = facilitator?.toJson();
    return json;
  }
}

class Sections {
  String? name;
  String? slug;
  List<Lessons>? lessons;

  Sections({
    this.name,
    this.slug,
    this.lessons,
  });

  Sections.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    slug = json['slug'] as String?;
    lessons = (json['lessons'] as List?)
        ?.map((dynamic e) => Lessons.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['slug'] = slug;
    json['lessons'] = lessons?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Lessons {
  dynamic sectionId;
  dynamic courseId;
  String? name;
  String? content;
  String? shortDesc;
  dynamic duration;
  String? slug;
  dynamic fileId;
  String? type;
  String? url;
  String? previewUrl;
  bool? active;
  bool? displayOrder;
  dynamic originId;
  String? language;
  dynamic createUser;
  dynamic updateUser;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  dynamic imageId;
  String? icon;

  Lessons({
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
    sectionId = json['sectionId'] as dynamic;
    courseId = json['courseId'] as dynamic;
    name = json['name'] as String?;
    content = json['content'] as String?;
    shortDesc = json['shortDesc'] as String?;
    duration = json['duration'] as dynamic;
    slug = json['slug'] as String?;
    fileId = json['fileId'] as dynamic;
    type = json['type'] as String?;
    url = json['url'] as String?;
    previewUrl = json['previewUrl'] as String?;
    active = json['active'] as bool?;
    displayOrder = json['displayOrder'] as bool?;
    originId = json['originId'] as dynamic;
    language = json['language'] as String?;
    createUser = json['createUser'] as dynamic;
    updateUser = json['updateUser'] as dynamic;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    deletedAt = json['deletedAt'] as String?;
    imageId = json['imageId'] as dynamic;
    icon = json['icon'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
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

class Facilitator {
  String? name;
  String? degree;
  String? skill;
  dynamic ratings;
  dynamic courses;
  dynamic students;
  dynamic reviews;
  String? imageUrl;

  Facilitator({
    this.name,
    this.degree,
    this.skill,
    this.ratings,
    this.courses,
    this.students,
    this.reviews,
    this.imageUrl,
  });

  Facilitator.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    degree = json['degree'] as String?;
    skill = json['skill'] as String?;
    ratings = json['ratings'] as dynamic;
    courses = json['courses'] as dynamic;
    students = json['students'] as dynamic;
    reviews = json['reviews'] as dynamic;
    imageUrl = json['imageUrl'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['degree'] = degree;
    json['skill'] = skill;
    json['ratings'] = ratings;
    json['courses'] = courses;
    json['students'] = students;
    json['reviews'] = reviews;
    json['imageUrl'] = imageUrl;
    return json;
  }
}