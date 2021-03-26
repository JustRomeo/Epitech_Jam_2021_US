import os
import sys
import json
import time
import random
import socket
import requests

from random import *
from flask import json
from flask import request
from flask import jsonify
from flask import Response
from flask import Blueprint
from flask_cors import CORS
from flask import make_response
from flask_cors import cross_origin

APP = Blueprint('user', __name__, url_prefix='/user')

def generateToken(nbr : int = 25):
    token : str = ""

    if nbr < 1:
        nbr = 25

    for i in range(0, nbr):
        r = randint(1, 3)
        if r == 1:
            token += str(randint(0, 9))
        elif r == 2:
            token += chr(ord('a') + randint(0, 25))
        elif r == 3:
            token += chr(ord('A') + randint(0, 25))
        else:
            print(r)
    return token

def howManyinDb():
    liste = glob.glob("../Database/")
    liste.sort()
    return len(liste)
def getFromDB(username : str, password : str):
    liste = glob.glob("../Database/")
    liste.sort()

    for _file in liste:
        try:
            if getData(_file)['username'] == username and getData(_file)['password'] == password:
                return getData(_file)
        except Exception as e:
            print("Error in loading:", e)
    return None

def getData(path : str):
    if not os.path.exists(path):
        return None
    else:
        try:
            with open(path, 'r') as json_file:
                loaded = json.load(json_file)
            return loaded
        except:
        return None
    return None
def saveinFile(filepath : str, data : dict):
    if path == None or data == None:
        return
    with open(filepath, 'w+') as f:
        json.dump(data, f)

@APP.route('/create', methods=['POST', 'OPTIONS'])
@cross_origin()
def create():
    root : str = "../Database/"
    try:
        data = request.get_json()
        username = data['username']
        password = data['password']

        token : str = generateToken(150)
        while os.path.exists(root + "/" + token):
            token = generateToken(150)
        toSave = {
            "lvl": 1,
            "token": token,
            "username": username,
            "password": password,
            "mission": {"megots": 0, "CarbonEco": 0, "WaterLiter": 0},
            "name": username.split(" ")[0] if " " in username else (username.split(".")[0] if "." in username else username)
        }
        saveinFile(root + "/" + token)
        return {"status": "success", "token": token}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

@APP.route('/getInfo', methods=['POST', 'OPTIONS'])
@cross_origin()
def getInfo():
    try:
        data = request.get_json()
        token = data['token']
        if not os.path.exists(root + "/" + token):
            raise ValueError("Token Unknown")
        getData(root + "/" + token)

        jsonn = {"status": "success"}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

@APP.route('/connect', methods=['POST', 'OPTIONS'])
@cross_origin()
def connect():
    try:
        data = request.get_json()
        username = data['username']
        password = data['password']

        user = getFromDB(username, password)
        if user == None:
            raise ValueError("Unknown user.")

        jsonn = {"status": "success", "data": user}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn
