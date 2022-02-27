#!/usr/bin/python3

import cgi, cgitb
import os, sys

jsonFilename = None
jsonPath = '/etc/nginx/cgi-bin/cs361/'
queryString = os.environ['QUERY_STRING']
parameters = [i.split('=') for i in queryString.split('&')]

for key, value in parameters:
    if key == 'imageSet':
        if value == 'places':
            jsonFilename = 'places.json'
        elif value == 'pokemon':
            jsonFilename = 'pokemon.json'

if not jsonFilename:
    print('Status: 404 Not Found\n')
    sys.exit(0) 

print('Content-Type: application/json\n')

jsonPath += jsonFilename

with open(jsonPath, 'r') as f:
    print(f.read())
