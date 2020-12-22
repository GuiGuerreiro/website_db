#!/usr/bin/python3

import login
import psycopg2
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Remove Substation</title>')
print('</head>')
print('<body>')

connection = psycopg2.connect(login.credentials)
cursor = connection.cursor()
form = cgi.FieldStorage()
info = form.getvalue('s_id')  # s_id comes in string format
(lat, long) = info.split(",")  # here i split it into lat and long

sql_delete_station = 'DELETE FROM substation WHERE (gpslat, gpslong) = (%s, %s);'     # DELETE substation
sql_delete_transformer = 'DELETE FROM transformer WHERE id = (%s);'  # DELETE transformer
sql_delete_etransformer = 'DELETE FROM element WHERE id = (%s);'  # DELETE transformer element
sql_delete_incident = 'DELETE FROM incident WHERE id =(%s);'  # DELETE incidents
sql_delete_analyses = 'DELETE FROM analyses WHERE id =(%s);'  # DELETE analyses where incident appears
sql_tid = 'SELECT id FROM transformer WHERE (gpslat, gpslong) = (%s, %s);'  # Get transformer id


try:
    cursor.execute(sql_tid, [lat, long])
    tid = cursor.fetchall()
    for t_id in tid:
        cursor.execute(sql_delete_analyses, [t_id])      # delete transformer incident analyses
        cursor.execute(sql_delete_incident, [t_id])      # delete transformer incidents
        cursor.execute(sql_delete_transformer, [t_id])   # delete transformer
        cursor.execute(sql_delete_etransformer, [t_id])  # delete transformer element
    cursor.execute(sql_delete_station, [lat, long])

    connection.commit()
    cursor.close()
    print('<meta http-equiv="refresh" content="0; url=https://web.tecnico.ulisboa.pt/ist187010/substation.cgi" />')
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/substation.cgi">Return</a></p>')
print('</body>')
print('</html>')
