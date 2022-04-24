from csv import DictReader
import matplotlib.pyplot as plt
import numpy as np

def readCSV():
    filename = "k_d_07_2021.csv"

    with open(filename,'r') as read_obj:
        reader = DictReader(read_obj)
        list_of_rows = list(reader)
    return list_of_rows


def getPlaces(list_of_rows):
    places = []
    for row in list_of_rows:
        if row.get('Nazwa_stacji') not in places:
            places.append(row.get('Nazwa_stacji'))
    print(places)


def maxTempChart(list_of_rows):
    StationsToCompare = ['OLECKO','BRENNA','BORUCINO']   #wybrane metodą empiryczną -> sprawdzone na google maps, czy są daleko
    olecko = []
    brenna = []
    borucino = []
    for row in list_of_rows:
    
        if row.get('Nazwa_stacji') == 'OLECKO':
            olecko.append(float(row.get('Maksymalna_temperatura_dobowa')))
        if row.get('Nazwa_stacji') == 'BRENNA':
            brenna.append(float(row.get('Maksymalna_temperatura_dobowa')))
        if row.get('Nazwa_stacji') == 'BORUCINO':
            borucino.append(float(row.get('Maksymalna_temperatura_dobowa')))

    
    data = [olecko, brenna, borucino]
    fig = plt.figure(figsize =(10, 7))
    ax = fig.add_axes([0, 0, 1, 1])
    bp = ax.boxplot(data)
    plt.show()


def dayTempDiff(list_of_rows):
    StationsToCompare = ['OLECKO','BRENNA','BORUCINO']   #wybrane metodą empiryczną -> sprawdzone na google maps, czy są daleko
    olecko = []
    brenna = []
    borucino = []
    for row in list_of_rows:
    
        if row.get('Nazwa_stacji') == 'OLECKO':
            olecko.append(float(row.get('Maksymalna_temperatura_dobowa') - float(row.get('Minimalna_temperatura_dobowa')))
        if row.get('Nazwa_stacji') == 'BRENNA':
            brenna.append(float(row.get('Maksymalna_temperatura_dobowa') - float(row.get('Minimalna_temperatura_dobowa'))))
        if row.get('Nazwa_stacji') == 'BORUCINO':
            borucino.append(float(row.get('Maksymalna_temperatura_dobowa') - float(row.get('Minimalna_temperatura_dobowa'))))

    
    data = [olecko, brenna, borucino]
    fig = plt.figure(figsize =(10, 7))
    ax = fig.add_axes([0, 0, 1, 1])
    bp = ax.boxplot(data)
    plt.show()

list_of_rows=readCSV()
maxTempChart(list_of_rows)
