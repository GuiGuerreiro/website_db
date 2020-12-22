#!/usr/bin/python3

import login
import psycopg2
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Remove transformer</title>')
print('</head>')
print('<body>')

connection = psycopg2.connect(login.credentials)
cursor = connection.cursor()
form = cgi.FieldStorage()
b_id = form.getvalue('tid')


sql1 = 'DELETE FROM transformer WHERE id = (%s);'     # DELETE transformer
sql2 = 'DELETE FROM element WHERE id = (%s);'         # DELETE element

sql5 = 'DELETE FROM incident WHERE id IN ' \
      '(SELECT id FROM incident WHERE id = (%s) ' \
      'UNION SELECT id FROM element WHERE id = (%s));'  # DELETE incidents where transformer appears

sql6 = 'DELETE FROM analyses WHERE id IN ' \
      '(SELECT id FROM analyses WHERE id = (%s) ' \
      'UNION SELECT id FROM incident WHERE id = (%s));'  # DELETE analyses where analyses appears

try:
    cursor.execute(sql6, [b_id, b_id])
    cursor.execute(sql5, [b_id, b_id])
    cursor.execute(sql1, [b_id])
    cursor.execute(sql2, [b_id])

    connection.commit()
    cursor.close()
    print('<meta http-equiv="refresh" content="0; url=https://web.tecnico.ulisboa.pt/ist187010/transformer.cgi" />')
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/transformer.cgi">Return</a></p>')
print('</body>')
print('</html>')
