import json
import os
import urllib3
from requests import Session

from config import settings

urllib3.disable_warnings()

LAUNCH_FILE_PATH = '.'

RP_URL = settings.rp_url
RP_TOKEN = settings.rp_token
RP_PROJECT = settings.rp_project

RP_ENDPOINT_LAUNCHES = f'{RP_URL}/api/v1/{RP_PROJECT}/launch/'
RP_ENDPOINT_CLUSTERS = f'{RP_ENDPOINT_LAUNCHES}cluster/'
RP_ENDPOINT_TESTS = f'{RP_URL}/api/v1/{RP_PROJECT}/item'

DATA_DIR = 'data'

def check_for_errors(resp, *args, **kwargs):
    resp.raise_for_status()

def setup_session():
    sesh = Session()
    sesh.hooks['response'] = check_for_errors
    sesh.headers = {"Authorization": f"bearer {RP_TOKEN}"}
    sesh.verify = False
    return sesh

def get_launches(sesh, launch_name):
    launches = []
    pages = 1
    for i in range(1, pages+1):
        req = sesh.get(
            RP_ENDPOINT_LAUNCHES,
            params={
                'filter.eq.name': launch_name,
                'page.page': i,
                'page.size': 500,
                'page.sort': 'id,desc',
            }
        )
        pages = req.json()['page']['totalPages']
        launches += req.json()['content']
    return launches

def fetch_clusters(sesh, launch_id):
    clusters = sesh.get(RP_ENDPOINT_CLUSTERS + str(launch_id), params={'page.size': 500}).json()['content']

    for c in clusters:
        test = sesh.get(
            f'{RP_ENDPOINT_TESTS}',
            params={
                'filter.has.clusterId': c['id'],
                'filter.eq.launchId': str(launch_id)
            }
        ).json()['content']
        c['testItems'] = test
    return {'launch_id': str(launch_id), 'clusters': clusters}

def launch_write(sesh, clusters, rewrite=False):
    launch_id = clusters['launch_id']
    # TODO: sanitize if clusters/testItems is empty
    sample_attributes = clusters['clusters'][0]['testItems'][0]['attributes']
    sat_version = [item["value"] for item in sample_attributes if item["key"] == "SatelliteVersion"][0]  
    snap_version = [item["value"] for item in sample_attributes if item["key"] == "SnapVersion"][0]  

    filename = f'{DATA_DIR}/{sat_version}/{snap_version}/launch_{launch_id}.json'
    try:
        os.makedirs(os.path.dirname(filename), exist_ok=False)
        with open(filename, 'w') as f:
            f.write(json.dumps(clusters))
    except FileExistsError:
        if rewrite:
            os.makedirs(os.path.dirname(filename), exist_ok=True)
            with open(filename, 'w') as f:
                f.write(json.dumps(clusters))


def launch_delete(launch_id):
    os.remove(f'{LAUNCH_FILE_PATH}/launch_{launch_id}.json')
    return launch_id

def list_versions():
    directories = next(os.walk(DATA_DIR))[1]
    directories.sort(reverse=True)
    return directories

