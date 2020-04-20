

#jumlah data user id harus sama dengan jumlah data status
userid = [
    '0240310116', '0240810116', '0245710117', '0245810117', '0245910117', '0246210117', '0246410117', '0246510117', '0246610117', '0246710117', '0246810117', '0246910117', '0247110117', '0247210117'
    ]
status = [
    'Sakit', 'Hadir', 'Izin', 'Alpa', 'Hadir', 'Hadir', 'Hadir', 'Hadir', 'Hadir', 'Hadir', 'Hadir', 'Hadir', 'Hadir', 'Hadir'
    ]

dictionary = {}
num = 0
while num < len(userid):
    dictionary[userid[num]] = status[num]
    num +=1

def fungsi():
    count = 0
    while count < len(userid):
        if dictionary[userid[count]] == "Hadir":
            print ("True")
        else:
            print ("False")
        count += 1


fungsi()
