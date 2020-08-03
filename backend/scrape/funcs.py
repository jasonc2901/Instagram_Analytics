import scrape.scraper as scraper

FOLLOWERS_LIST = []
FOLLOWING_LIST = []
LIKES_LIST = []

def setup(username, password):
    img_url, num_posts, user_bio = scraper.load(username, password)

    f = open(f"scrape/user_data/@{username}/followers.txt", "r")
    for x in f:
        FOLLOWERS_LIST.append(x)
    f.close()

    print(f"length of followers_list {len(FOLLOWERS_LIST)}")

    f2 = open(f"scrape/user_data/@{username}/following.txt", "r")
    for r in f2:
        FOLLOWING_LIST.append(r)
    f2.close()
    print(f"length of following_list {len(FOLLOWING_LIST)}")

    return username, img_url, num_posts, user_bio

def clear():
    FOLLOWERS_LIST.clear()
    FOLLOWING_LIST.clear()
    LIKES_LIST.clear()

def get_users_not_following_back(username):
    #retrieve data from the two files created
    #followers who don't follow you back
    users_not_following_us = [x for x in FOLLOWING_LIST if x not in FOLLOWERS_LIST]

    not_following_us = open(f"scrape/user_data/@{username}/users_not_following_us.txt", "w")
    for i in users_not_following_us:
        not_following_us.write(i)
    not_following_us.close()
    
    return users_not_following_us

def get_users_you_dont_follow_back(username):
    #followers who you don't follow back
    users_we_dont_follow_back = [x for x in FOLLOWERS_LIST if x not in FOLLOWING_LIST]

    not_following_them_back = open(f"scrape/user_data/@{username}/users_we_dont_follow_back.txt", "w")
    for i in users_we_dont_follow_back:
        not_following_them_back.write(i)
    not_following_them_back.close()
    
    return users_we_dont_follow_back

def get_num_followers():
    return len(FOLLOWERS_LIST)

def get_all_followers():
    return FOLLOWERS_LIST

def get_all_following():
    return FOLLOWING_LIST

def get_num_following():
    return len(FOLLOWING_LIST)



