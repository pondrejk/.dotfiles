from fetch_report import *
from typing import Union

from fastapi import FastAPI

app = FastAPI()


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

@app.get("/versions/}")
def get_versions():
    # connect to sqlite
    # return json