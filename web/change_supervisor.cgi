#!/usr/bin/python3

import psycopg2
import cgi
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Change Supervisor</title>')
print('</head>')
print('<body>')

connection = psycopg2.connect(login.credentials)
cursor = connection.cursor()
form = cgi.FieldStorage()
if form.getvalue('name'):
    name = form.getvalue('name')
    rua = form.getvalue('address')
    (lat, long) = (form.getvalue('lat'), form.getvalue('long'))
    print('<p>{} {}</p>'.format(name, rua))
    sql_update_supervisor = 'UPDATE substation SET (sname, saddress) = (%s, %s) WHERE (gpslat, gpslong) = (%s, %s);'
    try:
        cursor.execute(sql_update_supervisor, [name, rua, lat, long])
        connection.commit()
        cursor.close()

    except Exception as e:
        # Print errors on the webpage if they occur
        print('<h1>An error occurred.</h1>')
        print('<p>{}</p>'.format(e))

else:
    print('<p> 1 </p>')
    locality = form.getvalue('locality')
    (lat, long) = (form.getvalue('lat'), form.getvalue('long'))

    sql_get_supervisors = 'SELECT name, address FROM supervisor'
    cursor.execute(sql_get_supervisors)
    supervisor_list = cursor.fetchall()

    print('<h1>Change supervisor of %s substation at %s %s</h1>' % (locality, lat, long))

    print('<p>Available supervisors</p>')
    print('<table border="5">')
    print('<tr>')
    print('<th>Supervisors</th><th>Address</th>')
    print('</tr>')
    print('<form method="post">')
    for row in supervisor_list:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
        name = row[0]
        rua = row[1]
        print('<p>{} {}</p>'.format(name, rua))
        print('<td><form>'
              '<input type = "hidden" name="name" value = "{}"/> '
              '<input type = "hidden" name="address" value = "{}"/> '
              '<input type = "hidden" name="lat" value = "{}"/> '
              '<input type = "hidden" name="long" value = "{}"/> '
              '<button id = "w3-btn"> change </button>'
              '</form></td>'.format(name, rua, lat, long))
        print('</tr>')
    print('</table>')
    print('<input type="submit" value="Submit">')
    print('</form>')

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/supervisor.cgi">Return</a></p>')
print('</body>')
print('</html>')
