import os
import sys
import time
import json
import glob
import requests

from flask import Flask
from flask import request
from flask import jsonify
from flask import Response
from flask_cors import CORS
from flask_cors import cross_origin

port : int = 3000

from user import APP as user
from Image import APP as image
from Application import APP as appli

APP = Flask(__name__)
CORS(APP)

APP.register_blueprint(user)
APP.register_blueprint(image)
APP.register_blueprint(appli)

@APP.route('/ping', methods=['GET'])
@cross_origin()
def defaultPing():
    return Response("pong", mimetype='text/html')

@APP.route('/pingconnection', methods=['GET', 'OPTIONS'])
@cross_origin()
def pingconnection():
    return {"status":"connected"}

if __name__ == "__main__":
    try:
        APP.run(ssl_context='adhoc', host="0.0.0.0", port=port, debug=False)
    except:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
        log = exc_type + " | " +  fname + " | " +  exc_tb.tb_lineno
        APP.logger.info(log)
