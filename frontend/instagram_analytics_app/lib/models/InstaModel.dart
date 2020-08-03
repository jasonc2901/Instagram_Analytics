class InstaModel {
  int status;
  Data data;

  InstaModel({this.status, this.data});

  InstaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String username;
  int numFollowers;
  int numFollowing;
  List<String> following;
  List<String> followers;
  List<String> followersNotFollowingBack;
  List<String> followersYouDontFollowBack;
  int numPosts;
  String userBio;
  String imgUrl;

  Data(
      {this.username,
      this.numFollowers,
      this.numFollowing,
      this.following,
      this.followers,
      this.followersNotFollowingBack,
      this.followersYouDontFollowBack,
      this.numPosts,
      this.userBio,
      this.imgUrl});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    numFollowers = json['num_followers'];
    numFollowing = json['num_following'];
    following = json['all_following'].cast<String>();
    followers = json['all_followers'].cast<String>();
    followersNotFollowingBack =
        json['followers_not_following_back'].cast<String>();
    followersYouDontFollowBack =
        json['followers_you_dont_follow_back'].cast<String>();
    numPosts = json['num_posts'];
    userBio = json['user_bio'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['num_followers'] = this.numFollowers;
    data['num_following'] = this.numFollowing;
    data["all_following"] = this.following;
    data["all_followers"] = this.followers;
    data['followers_not_following_back'] = this.followersNotFollowingBack;
    data['followers_you_dont_follow_back'] = this.followersYouDontFollowBack;
    data['num_posts'] = this.numPosts;
    data['user_bio'] = this.userBio;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
