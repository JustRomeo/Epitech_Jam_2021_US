import os
import sys
import json
import glob
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
    liste = glob.glob("Database/*")
    liste.sort()
    return len(liste)
def getFromDB(username : str, password : str):
    liste = glob.glob("Database/people/*")
    liste.sort()
    for _file in liste:
        try:
            if getData(_file)['username'] == username and getData(_file)['password'] == password:
                return getData(_file)
        except Exception as e:
            print("Error in loading:", e)
    return None
def isInDb(username : str):
    liste = glob.glob("Database/people/*")
    liste.sort()
    for _file in liste:
        try:
            if getData(_file)['username'] == username:
                return True
        except Exception as e:
            print("Error in loading:", e)
    return False

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
    if filepath == None or data == None:
        return
    with open(filepath, 'w+') as f:
        json.dump(data, f)

@APP.route('/create', methods=['POST', 'OPTIONS'])
@cross_origin()
def create():
    root : str = "Database/people"
    try:
        data = request.get_json()
        username = data['username']
        password = data['password']

        if isInDb(username):
            raise ValueError("Username Already Taken.")
        token : str = generateToken(150)
        while os.path.exists(root + "/" + token):
            token = generateToken(150)
        toSave = {
            "lvl": 1,
            "percent": 0.0,
            "token": token,
            "language": "En",
            "certified": False,
            "username": username,
            "password": password,
            "mission": {"dechets": 0, "CarbonEco": 0, "WaterLiter": 0},
            "name": username.split(" ")[0] if " " in username else (username.split(".")[0] if "." in username else username)
        }
        saveinFile(root + "/" + token, toSave)
        return {"status": "success", "token": token}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

@APP.route('/connect', methods=['POST', 'OPTIONS'])
@cross_origin()
def connect():
    root : str = "Database/people"
    try:
        data = request.get_json()
        username = data['username']
        password = data['password']

        user = getFromDB(username, password)
        if user == None:
            raise ValueError("Unknown user.")
        token = user['token']
        user['lvl'] = 1
        user['percent'] = 0
        user['lvl'] += int((int(user['mission']['dechets']) + int(user['mission']['CarbonEco']) + int(user['mission']['WaterLiter'])) / 30)
        user['percent'] += float((int(user['mission']['dechets']) + int(user['mission']['CarbonEco']) + int(user['mission']['WaterLiter'])) % 30)
        jsonn = {"status": "success", "data": user}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

@APP.route('/setLanguage', methods=['POST', 'OPTIONS'])
@cross_origin()
def setLanguage():
    root : str = "Database/people"
    try:
        data = request.get_json()
        token = data['token']
        language = data['language']
        filepath : str = root + "/" + token

        if not os.path.exists(filepath):
            raise ValueError("Token Unknown")
        user = getData(filepath)
        if user == None:
            raise ValueError("Error when loading user :/")
        user['language'] = language
        saveinFile(filepath, user)
        jsonn = {"status": "success", "data": user}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

@APP.route('/addValue', methods=['POST', 'OPTIONS'])
@cross_origin()
def addValue():
    root : str = "Database/people"
    try:
        data = request.get_json()
        token = data['token']
        Co2 = float(data['co2'])
        Water = float(data['water'])
        Garbage = float(data['dechet'])
        filepath : str = root + "/" + token

        if not os.path.exists(filepath):
            raise ValueError("Token Unknown")
        user = getData(filepath)
        if user == None:
            raise ValueError("Error when loading user :/")

        user["mission"]["CarbonEco"] += Co2
        user["mission"]["dechets"] += Garbage
        user["mission"]["WaterLiter"] += Water
        user['lvl'] = 0
        user['lvl'] += int(user['mission']['dechets'] / 30)
        user['lvl'] += int(user['mission']['CarbonEco'] / 30)
        user['lvl'] += int(user['mission']['WaterLiter'] / 30)
        user['percent'] += (int(user['mission']['dechets'] % 30) + int(user['mission']['CarbonEco'] % 30) + int(user['mission']['WaterLiter'] % 30)) / 3

        saveinFile(filepath, user)
        jsonn = {"status": "success", "data": user}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn
