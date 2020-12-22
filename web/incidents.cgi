#!/usr/bin/python3

import psycopg2

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Incidents</title>')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    print('<h1>Incidents List</h1>')
    cursor = connection.cursor()

    # Making query
    sql_incident = 'SELECT instant, id, severity, description FROM incident ORDER BY instant;'
    cursor.execute(sql_incident)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<table border="5">')
    print('<tr><td>Instant of Occurrence</td><td>Element ID</td><td>Severity</td><td>Description</td></tr>')

    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
        if row[1][0] != 'L':
            instant = row[0]
            e_id = row[1]
            print('<td><form action = "edit_description.cgi" method="post">'
                  '<input type= "hidden" name="info" value = "{},{}">'
                  '<button id = "w3-btn"> edit </button>'
                  '</form></td>'.format(instant, e_id))

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
