from flask import request, jsonify
from flask_restful import Resource
import json
from scrape import funcs

class UserResource(Resource):
    def get(self):
        #clears previous followers/following list to prevent duplication
        funcs.clear()
        
        #account details pulled from the request args
        username = request.args.get('username', type = str)
        password = request.args.get('password', type = str)

        #initialising the instagram data
        userLogin, img_url, num_posts, user_bio = funcs.setup(username, password)

        #user profile stats
        num_followers = funcs.get_num_followers()
        num_following = funcs.get_num_following()
        followers_not_following_back = funcs.get_users_not_following_back(username)
        followers_you_dont_follow_back = funcs.get_users_you_dont_follow_back(username)
        following_list = funcs.get_all_following()
        followers_list = funcs.get_all_followers()

        if not username:
            return {'status': 400, 'data': 'no_username_provided'}, 400
        elif not password:
            return {'status': 400, 'data': 'no_password_provided'}, 400

        user = {
            'username' : username,
            'num_followers' : num_followers,
            'num_following' : num_following,
            'all_following' : following_list,
            'all_followers' : followers_list,
            'followers_not_following_back' : followers_not_following_back,
            'followers_you_dont_follow_back' : followers_you_dont_follow_back,
            'num_posts' : num_posts,
            'user_bio' : user_bio,
            'img_url' : img_url
        }

        return {'status': 200, 'data': user}, 200
            