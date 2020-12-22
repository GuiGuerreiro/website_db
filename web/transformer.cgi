#!/usr/bin/python3

import psycopg2
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Transformer</title>')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    print('<h1>List of Transformers</h1>')
    cursor = connection.cursor()

    # Making query
    sql_transformer = 'SELECT id FROM transformer ORDER BY id;'
    cursor.execute(sql_transformer)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<table border="5">')
    print('<tr>')
    print('<th>Transformer ID</th>')
    print('</tr>')

    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
            print('<td><form action = "remove_transformer.cgi" method="post">'
                  '<input type = "hidden" name="tid" value = "{}"/> '
                  '<button id = "w3-btn"> delete </button>'
                  '</form></td>'.format(value))
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
