#!/usr/bin/env python3
# -*- coding: utf8 -*-


__author__ = 'Robin Wittler'
__contact__ = 'robin.wittler@cloudwuerdig.com'
__version__ = '0.0.1'


import os
import pytz
import json
import socket
from uuid import uuid4
from random import randint
from fastapi import FastAPI
from datetime import datetime


app = FastAPI()
stateful_path = "/data/stateful.json"


@app.on_event("startup")
async def ensure_stateful_information():
    if not os.path.exists(stateful_path):
        data = {
            "date": datetime.now(pytz.utc).isoformat(),
            "uuid4": f"{uuid4()}",
            "hostname": f"{socket.gethostname()}"
        }
        with open(stateful_path, "w") as fp:
            fp.write(json.dumps(data))


@app.get("/")
async def get_hostname():
    with open(stateful_path) as fp:
        data = json.loads(fp.read())
    data["random"] = randint(100, 999)
    return data
