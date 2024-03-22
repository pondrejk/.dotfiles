import json
import os
import urllib3
from requests import Session

urllib3.disable_warnings()

LAUNCH_FILE_PATH = '.'

RP_URL = 'http://reportportal-sat-qe.apps.ocp-c1.prod.psi.redhat.com'
RP_TOKEN = 'e603e14d-daa7-4042-bbfa-7ba349115408'
RP_PROJECT = 'Satellite6'

RP_ENDPOINT_LAUNCHES = f'{RP_URL}/api/v1/{RP_PROJECT}/launch/'
RP_ENDPOINT_CLUSTERS = f'{RP_ENDPOINT_LAUNCHES}cluster/'
RP_ENDPOINT_TESTS = f'{RP_URL}/api/v1/{RP_PROJECT}/item'

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
                'page.size': 2000,
                'page.sort': 'id,desc',
            }
        )
        pages = req.json()['page']['totalPages']
        launches += req.json()['content']
    return launches


def fetch_clusters(sesh, launch_id):
    clusters = sesh.get(RP_ENDPOINT_CLUSTERS + str(launch_id)).json()['content']

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

def launch_write(sesh, clusters):
    launch_id = clusters['launch_id']
    sample_attributes = clusters['clusters'][0]['testItems'][0]['attributes']
    sat_version = [item.value for item in sample_attributes if item.key == "SatelliteVersion"][0]  
    snap_version = [item.value for item value in sample_attributes if item.key == "SnapVersion"][0]  

    with open(f'data/{sat_version}/{snap_version}/launch_{launch_id}.json', 'w') as f:
        f.write(json.dumps(clusters))

def launch_delete(launch_id):
    os.remove(f'{LAUNCH_FILE_PATH}/launch_{launch_id}.json')
    return launch_id
