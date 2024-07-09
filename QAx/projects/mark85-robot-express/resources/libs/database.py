from robot.api.deco import keyword
from pymongo import MongoClient

client = MongoClient('mongodb+srv://renataglbmelo:renataqa@cluster0.itv6jei.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

db = client['markdb']

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)