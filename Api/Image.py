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
from flask import send_file
from flask import Blueprint
from flask_cors import CORS
from flask import make_response
from flask_cors import cross_origin

APP = Blueprint('image', __name__, url_prefix='/image')

@APP.route('/get')
def get_image():
    myType = request.args.get('type')
    if  myType == '1':
       filename = '../Database/image/BacEauPluie.jpeg'
    elif  myType == '2':
       filename = '../Database/image/poubelle.jpeg'
    return send_file(filename, mimetype='image/jpeg')
