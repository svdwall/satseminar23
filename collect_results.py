import csv

points_threshhold = 338 / 2

num_sheets=7

data = {
        "natalia": {},
        "benjamin": {},
        "thies": {}
        }
refdata = {}

file = 'results.csv'
reffile = 'references.csv'

def append(row):
    file = row[0]
    stud = row[1]
    res = row[2]
    time = row[3]

    data[stud][file] = { "time": time, "res": res }


with open(file) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        if row != []:
            row_stripped = list(map(lambda el: el.strip(), row))
            append(row_stripped)
    csv_file.close()

with open(reffile) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        if row != []:
            row_stripped = list(map(lambda el: el.strip(), row))
            refdata[row_stripped[0]] = row_stripped[1]
    csv_file.close()


results = []

for stud in data:
    tos = 0
    correct = 0
    false = 0
    exception = 0
    points = 0
    for file in data[stud]:
        res = data[stud][file]['res']
        if res == "EXCEPTION":
            exception += 1
            continue
        if res == "TIMEOUT":
            tos += 1
            continue
        if res == refdata[file]:
            correct += 1
            if res == "SAT":
                points += 1
            else:
                points += 3
        else:
            false += 1
            points -= 5

    results.append( [ stud, correct, false, tos, exception, points] )

print("stud, correct, false, tos, exception, points")
print(results)

