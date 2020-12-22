#!/usr/bin/python3

import psycopg2
import cgi
import login


print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Edit description</title>')
print('</head>')
print('<body>')

instant = ""
e_id = ""
connection = psycopg2.connect(login.credentials)
cursor = connection.cursor()
form = cgi.FieldStorage()
if form.getvalue('info'):
    info = form.getvalue('info')  # s_id comes in string format
    (instant, e_id) = info.split(",")

if form.getvalue('desc'):
    txt = form.getfirst('desc')
    info = form.getvalue('info')
    (instant, e_id) = info.split(",")
    sql_update = 'UPDATE incident SET description = (%s) WHERE (instant, id) = (%s, %s);'
    data = (txt, instant, e_id)
    try:
        cursor.execute(sql_update, data)
        connection.commit()
        cursor.close()
        print('<meta http-equiv="refresh" content="0; url=https://web.tecnico.ulisboa.pt/ist187010/incidents.cgi" />')
    except Exception as e:
        # Print errors on the webpage if they occur
        print('<h1>An error occurred.</h1>')
        print('<p>{}</p>'.format(e))
        print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/incidents.cgi">Return</a></p>')


sql_incident = 'SELECT severity, description FROM incident WHERE (instant, id) = (%s, %s);'
cursor.execute(sql_incident, [instant, e_id])
result = cursor.fetchall()
num = len(result)

print('<h1>Editing description of incident at %s %s</h1>' % (e_id, instant))
text = ""
for row in result:
    for value in row:
        text = value
    print('<form>'
          '<label for="desc">Incident Description:</label>'
          '<br>'
          '<textarea id="desc" name ="desc" rows="5" cols="50">'
          '{}</textarea>'
          '<br><br>'
          '<input type="hidden" name="info" value="{},{}">'
          '<input type="submit" value="Submit"></form>'.format(text, instant, e_id))
cursor.close()

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/incidents.cgi">Return</a></p>')
print('</body>')
print('</html>')
