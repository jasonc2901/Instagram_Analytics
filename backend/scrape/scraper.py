from instaloader import Instaloader, Profile
import os

def load(username,password):
    loader = Instaloader()
    login_name = username
    target_profile = username

    # login
    try:
        loader.load_session_from_file(login_name)
    except FileNotFoundError:
        loader.context.log("Session file does not exist yet - Logging in.")
    if not loader.context.is_logged_in:
        loader.login(username, password)
        loader.save_session_to_file()

    #if user is new, create them a folder to store their lists    
    if not os.path.exists(f"scrape/user_data/@{login_name}"):
        os.makedirs(f"scrape/user_data/@{login_name}")

    profile_pic_url, num_posts, biography = get_user_details(loader.context, target_profile)

    return profile_pic_url, num_posts, biography



def get_user_details(loader, username):
    profile = Profile.from_username(loader, username)
    followers = profile.get_followers()
    following = profile.get_followees()
    profile_pic = profile.get_profile_pic_url()
    total_posts = profile.mediacount
    bio = profile.biography
    
    f = open(f"scrape/user_data/@{username}/followers.txt", "w")
    for follower in followers:
        f.write(follower.username + '\n')
        
    f.close()
    
    f2 = open(f"scrape/user_data/@{username}/following.txt", "w")
    for user in following:
        f2.write(user.username + '\n')
    
    f2.close()

    followers = []
    following = []

    return profile_pic, total_posts, bio


    
    
