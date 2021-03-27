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

    value : float = 0
    for _file in liste:
        try:
            value += getData(_file)[key][key2]
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
            "dechets": countDataFromDB2("mission", "dechets"),
            "CarbonEco": countDataFromDB2("mission", "CarbonEco"),
            "WaterLiter": countDataFromDB2("mission", "WaterLiter"),
        }
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn

publ = [
    {"title": "Le Composte", "Desc": "Le composte permet de produire du terreau à partir de déchet organiques.", "img": "https://i0.wp.com/sivom-region-cluses.fr/wp-content/uploads/2017/06/composteur-credit-sivom.jpg?fit=1500%2C1125"},
    {"title": "Le Savon Maison", "Desc": "Le savon fait soi même c'est quand même vachement cool. Mais c'est pas une mince à faire.", "img": 'https://static1.beaute.fr/articles/2/12/07/2/@/32812-le-retour-en-grace-du-savon-article_full-2.jpg'},
    {"title": "Fermer le robinet quand on se brosse les dents !", "Desc": "Cela permet l'economie de beaucoup d'eau, rendez vous compte qu'a raison de 1L par minute, et de 3 minute par lavement, vous consommez minimum 6L d'eau par jour.", "img": "https://i.pinimg.com/originals/9e/dc/36/9edc36b72a7ead337b0af035acf7ea54.jpg"}
]

@APP.route('/getPublications', methods=['POST', 'OPTIONS'])
@cross_origin()
def getPublications():
    root : str = "Database/Publications/"
    try:
        data = request.get_json()
        liste = getData("Database/Publications/Publications")
        # if liste == None:
        #     raise ValueError("Cannot get Publications liste.")
        # print(publ)
        jsonn = {"status": "success", "data": publ}
    except Exception as e:
        return {"status": "Fail", "message": str(e)}
    return jsonn
