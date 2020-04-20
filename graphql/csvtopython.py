import csv
file = "namasiswa.csv"
file2 = "jadwal.csv"

jadwal = []
mahasiswas = []

with open(file2) as csvfile2: #read data pelajaran
    readCSV_2 = csv.reader(csvfile2, delimiter = ',') #csv function buat baca format .csv
    next(readCSV_2) #akan nge-skip row1 karena dianggap sebagai header
    for row in readCSV_2: #looping sebanyak row dalam file csv
        pelajaran = { #bikin element array bertipe dictionary
            'nama' : row[0], #masukin element 0 dari array row[] sbg value dr key 'nama'
            'tanggal' : row[1], #dst
            'mulai' : row[2],
            'selesai' : row[3]
        }
        jadwal.append(pelajaran)
        
with open(file) as csvfile:
    readCSV = csv.reader(csvfile, delimiter = ',')
    next(readCSV)
    for row in readCSV:
        person = {
            "nim" : row[0] ,
            "namaSiswa" : row[1],
            "presence" : row[2]
        }
        mahasiswas.append(person)
        
        




#jadwal.append(mahasiswas)

#print(mahasiswas[0]['namaSiswa']) #cara retrieve data individual

# print ("\n")
print(jadwal)
print(mahasiswas)