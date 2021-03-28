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

host : str = "https://localhost:3000"
APP = Blueprint('application', __name__, url_prefix='/application')

def howManyinDb():
    liste = glob.glob("Database/people/*")
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

def countDataFromDB2(key : str, key2 : str):
    liste = glob.glob("Database/people/*")
    liste.sort()

    value : int = 0
    for _file in liste:
        try:
            value += int(getData(_file)[key][key2])
        except Exception as e:
            print("Error in loading:", e)
    return value

def getData(path : str):
    if not os.path.exists(path):
        print(path + " do not exist.")
        return None
    else:
        try:
            with open(path, 'r') as json_file:
                loaded = json.load(json_file)
            return loaded
        except Exception as e:
            raise e
    return None
def saveinFile(filepath : str, data : dict):
    if filepath == None or data == None:
        return
    with open(filepath, 'w+') as f:
        json.dump(data, f)

@APP.route('/getInfos', methods=['POST', 'OPTIONS'])
@cross_origin()
def getInfo():
    try:
        jsonn = {
            "status": "success",
            "accounts": howManyinDb(),
            "dechets": int(countDataFromDB2("mission", "dechets")),
            "CarbonEco": int(countDataFromDB2("mission", "CarbonEco")),
            "WaterLiter": int(countDataFromDB2("mission", "WaterLiter")),
        }
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn


@APP.route('/getPublications', methods=['POST', 'OPTIONS'])
@cross_origin()
def getPublications():
    root : str = "Database/Publications/"
    try:
        data = request.get_json()
        liste = getData("Database/Publications/Publications")
        jsonn = {"status": "success", "data": liste}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

@APP.route('/getShop', methods=['POST', 'OPTIONS'])
@cross_origin()
def getShop():
    root : str = "Database/Publications/"
    try:
        data = request.get_json()
        liste = getData("Database/Publications/Shop")
        for elem in liste:
            elem['img'] = "/image/get?type=" + str(elem['img'])
        jsonn = {"status": "success", "data": liste}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn
