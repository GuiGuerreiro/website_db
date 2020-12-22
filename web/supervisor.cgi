#!/usr/bin/python3

import psycopg2

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Substation</title>')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    print('<h1>List of Substation</h1>')
    cursor = connection.cursor()

    # Making query
    sql_subs_sup = 'SELECT sname,saddress,locality, gpslat, gpslong FROM substation ORDER BY sname;'
    cursor.execute(sql_subs_sup)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<table border="5">')
    print('<tr><th>Supervisor</th><th>Address</th><th>Locality</th><th>Latitude</th><th>Longitude</th></tr>')

    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
        locality = row[2]
        (lat, long) = (row[3], row[4])
        print('<td><form action = "/ist187010/change_supervisor.cgi" method="post">'
              '<input type = "hidden" name="locality" value ="{}"/>'
              '<input type = "hidden" name="lat" value ="{}"/>'
              '<input type = "hidden" name="long" value ="{}"/>'
              '<button id = "w3-btn">change</button>'
              '</form></td>'.format(locality, lat, long))
        print('</tr>')
    print('</table>')

    # Closing connection
    cursor.close()


except Exception as error_description:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(error_description))
finally:
    if connection is not None:
        connection.close()

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/">Return</a></p>')
print('</body>')
print('</html>')
