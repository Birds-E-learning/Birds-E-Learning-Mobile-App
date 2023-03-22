class GetCoursesModel {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  GetCoursesModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetCoursesModel.fromJson(Map<String, dynamic> json) {
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
  List<TrendingCategories>? trendingCategories;
  List<PreferentialCategories>? preferentialCategories;
  List<QuickCategories>? quickCategories;

  ResponseData({
    this.trendingCategories,
    this.preferentialCategories,
    this.quickCategories,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    trendingCategories = (json['trendingCategories'] as List?)
        ?.map((dynamic e) =>
            TrendingCategories.fromJson(e as Map<String, dynamic>))
        .toList();
    preferentialCategories = (json['preferentialCategories'] as List?)
        ?.map((dynamic e) =>
            PreferentialCategories.fromJson(e as Map<String, dynamic>))
        .toList();
    quickCategories = (json['quickCategories'] as List?)
        ?.map(
            (dynamic e) => QuickCategories.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['trendingCategories'] =
        trendingCategories?.map((e) => e.toJson()).toList();
    json['preferentialCategories'] =
        preferentialCategories?.map((e) => e.toJson()).toList();
    json['quickCategories'] = quickCategories?.map((e) => e.toJson()).toList();
    return json;
  }
}

class TrendingCategories {
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
  List<TrendingCourses>? courses;

  TrendingCategories({
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

  TrendingCategories.fromJson(Map<String, dynamic> json) {
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
    courses = (json['courses'] as List?)
        ?.map(
            (dynamic e) => TrendingCourses.fromJson(e as Map<String, dynamic>))
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
    json['courses'] = courses?.map((e) => e.toJson()).toList();
    return json;
  }
}

class TrendingCourses {
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
  List<TrendingLessons>? lessons;

  TrendingCourses({
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
    this.lessons,
  });

  TrendingCourses.fromJson(Map<String, dynamic> json) {
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
    lessons = (json['lessons'] as List?)
        ?.map(
            (dynamic e) => TrendingLessons.fromJson(e as Map<String, dynamic>))
        .toList();
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
    json['lessons'] = lessons?.map((e) => e.toJson()).toList();
    return json;
  }
}

class TrendingLessons {
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

  TrendingLessons({
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

  TrendingLessons.fromJson(Map<String, dynamic> json) {
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

class PreferentialCategories {
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
  List<PreferentialCourses>? courses;

  PreferentialCategories({
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

  PreferentialCategories.fromJson(Map<String, dynamic> json) {
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
    courses = (json['courses'] as List?)
        ?.map((dynamic e) =>
            PreferentialCourses.fromJson(e as Map<String, dynamic>))
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
    json['courses'] = courses?.map((e) => e.toJson()).toList();
    return json;
  }
}

class PreferentialCourses {
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
  List<PreferentialLessons>? lessons;

  PreferentialCourses({
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
    this.lessons,
  });

  PreferentialCourses.fromJson(Map<String, dynamic> json) {
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
    lessons = (json['lessons'] as List?)
        ?.map((dynamic e) =>
            PreferentialLessons.fromJson(e as Map<String, dynamic>))
        .toList();
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
    json['lessons'] = lessons?.map((e) => e.toJson()).toList();
    return json;
  }
}

class PreferentialLessons {
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

  PreferentialLessons({
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

  PreferentialLessons.fromJson(Map<String, dynamic> json) {
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

class QuickCategories {
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
  List<QuickCourses>? courses;

  QuickCategories({
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

  QuickCategories.fromJson(Map<String, dynamic> json) {
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
    courses = (json['courses'] as List?)
        ?.map((dynamic e) => QuickCourses.fromJson(e as Map<String, dynamic>))
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
    json['courses'] = courses?.map((e) => e.toJson()).toList();
    return json;
  }
}

class QuickCourses {
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
  List<QuickLessons>? lessons;

  QuickCourses({
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
    this.lessons,
  });

  QuickCourses.fromJson(Map<String, dynamic> json) {
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
    lessons = (json['lessons'] as List?)
        ?.map((dynamic e) => QuickLessons.fromJson(e as Map<String, dynamic>))
        .toList();
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
    json['lessons'] = lessons?.map((e) => e.toJson()).toList();
    return json;
  }
}

class QuickLessons {
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

  QuickLessons({
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

  QuickLessons.fromJson(Map<String, dynamic> json) {
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
