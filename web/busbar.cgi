#!/usr/bin/python3

import psycopg2
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Bus Bar</title>')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    print('<h1>List of Bus bars</h1>')
    cursor = connection.cursor()

    # Submit a New bus Bar
    print('<h3>Add a Bus Bar</h3>')
    # The form will send the info needed for the SQL query
    print('<form action="add_busbar.cgi" method="post">')
    print('<p>Bus Bar ID: <input type="text" maxlength="10" required="required" name="new_busbar"/></p>')
    print('<p>Voltage: <input type="NUMBER" min ="0.0000" max ="999.9999" step = "0.0001" required="required" '
          'name="voltage"/></p>')
    print('<p><input type="submit" value="Submit"/></p>')
    print('</form>')

    # Making query
    sql_busbar = 'SELECT id FROM busbar ORDER BY id;'
    cursor.execute(sql_busbar)
    result = cursor.fetchall()
    num = len(result)

    # Displaying results
    print('<table border="5">')
    print('<tr>')
    print('<th>Busbar ID</th>')
    print('</tr>')

    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
            print('<td><form action = "remove_busbar.cgi" method="post">'
                  '<input type = "hidden" name="b_id" value = "{}"/> '
                  '<button id = "w3-btn"> delete </button>'
                  '</form></td>'.format(value))
        print('</tr>')
    print('</table>')

    # Closing connection
    cursor.close()

    print('<h2><a href="add_busbar.cgi">Add Bus Bars</a></h2>')
except Exception as error_description:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(error_description))
finally:
    if connection is not None:
        connection.close()

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/">Return</a></p>')

print('</body>')
print('</html>')
