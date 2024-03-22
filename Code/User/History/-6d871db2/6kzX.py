from fetch_report import *
from typing import Union

from fastapi.responses import JSONResponse, FileResponse
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:8080",
    "http://localhost:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.delete("/launches/{launch_id}")
def delete_launch_by_id(launch_id: int):
    status = launch_delete(launch_id)
    return {"launch": status}


@app.put("/launches/{launch_name}/fetch")
def fetch_launches(launch_name: str, rewrite: bool = False):
    sesh = setup_session()
    launches = get_launches(sesh, launch_name)
    for l in launches:
        clusters = fetch_clusters(sesh, l['id'])
        launch_write(sesh, clusters, rewrite)
    return {"launches": launches}

'''
# GET - vsetky launche pre sat verziu
@app.get("/launches/{launch_name}/{sat_ver}/{snap_ver}")
def get_launches(launch_name: str, sat_ver: str, snap_ver: str):
    # connect to sqlite
    # return json
'''

#TODO redo all this with sqlite
@app.get("/versions/")
def get_versions():
    versions = list_versions()
    return {"versions": versions}

@app.get("/snaps/{version}")
def get_snaps(version:str):
    snap = list_snaps_per_version(version)
    return {"versions": snap}

@app.get("/snaps/{version}/{snap}")
def get_snap_data(version: str, snap: str):
    path = snap_data(version, snap)
    return FileResponse(path)