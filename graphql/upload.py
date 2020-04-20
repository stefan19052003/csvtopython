import requests
import json
from datetime import date
import time
from csvtopython import mahasiswas

# print(mahasiswas)
gql_url = 'http://localhost:3000/graphql'

def getJadwal(value):
    url = gql_url
    index = 'nama'
    value = '7172 - SEMINAR EMMANUEL LEVINAS (THT)'

    payload = 'query{findJadwal(index: "%s", value: "%s") {_id nama tanggal mulai selesai mahasiswas {nama nim} } }' % (index, value)

    # payload = '''"mutation{
    #         findJadwal(index: "{}", value: "{}") {
    #             _id
    #             nama
    #             tanggal
    #             mulai
    #             selesai
    #             pelajaran {
    #             nama
    #             }
    #         }
    #     }'''.format(index, value)

    headers = {'Content-Type': 'application/json'}

    print(payload)
    print("stefan")
    r = requests.post(url, json={'query': payload}, headers=headers)
    print(r.status_code)
    print(r.reason)
    print(r.text)
    jadwals = json.loads(r.content)['data']['findJadwal']
    jadwals_sorted = sorted(jadwals, key=lambda student: student['mulai'])

    return jadwals_sorted

today = date.today()
print(today)

# jadwals = getJadwal('2020-04-02')
# print(jadwals)