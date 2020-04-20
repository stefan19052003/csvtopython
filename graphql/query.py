import requests

url = "http://localhost:3000/graphql"

payload = "{\"query\":\"query{findJadwal{\\n  _id\\n  _rev\\n  nama\\n  tanggal\\n}}\"}"
headers = {'content-type': 'application/json'}

response = requests.request("POST", url, data=payload, headers=headers)

print(response.text)