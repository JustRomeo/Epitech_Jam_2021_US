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

APP = Blueprint('application', __name__, url_prefix='/application')

def howManyinDb():
    liste = glob.glob("Database/*")
    liste.sort()
    return len(liste)
def getFromDB(username : str, password : str):
    liste = glob.glob("Database/*")
    liste.sort()
    for _file in liste:
        try:
            if getData(_file)['username'] == username and getData(_file)['password'] == password:
                return getData(_file)
        except Exception as e:
            print("Error in loading:", e)
    return None
def countDataFromDB2(key : str, key2 : str):
    liste = glob.glob("Database/*")
    liste.sort()

    value : float = 0
    for _file in liste:
        try:
            value += getData(_file)[key][key2]
        except Exception as e:
            print("Error in loading:", e)
    return value

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

@APP.route('/getInfos', methods=['POST', 'OPTIONS'])
@cross_origin()
def getInfo():
    try:
        jsonn = {
            "status": "success",
            "accounts": howManyinDb(),
            "dechets": countDataFromDB2("mission", "dechets"),
            "CarbonEco": countDataFromDB2("mission", "CarbonEco"),
            "WaterLiter": countDataFromDB2("mission", "WaterLiter"),
        }
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

