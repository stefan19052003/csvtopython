import requests

url = "http://localhost:3000/graphql"

payload = "{\"query\":\"mutation{addJadwal(\\n  nama: \\\"SSS\\\",\\n  tanggal: \\\"TEST\\\",\\n  mulai: \\\"TEST\\\",\\n  selesai: \\\"TEST\\\"\\n  tempat: \\\"TEST\\\",\\n  pelajaran: \\\"TEST\\\",\\n  mahasiswas: \\\"TEST\\\"\\n) {\\n  _id\\n  _rev\\n  nama\\n}}\"}"
headers = {'content-type': 'application/json'}

response = requests.request("POST", url, data=payload, headers=headers)

print(response.text)