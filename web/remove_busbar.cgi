#!/usr/bin/python3

import login
import psycopg2
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Remove bus_bar</title>')
print('</head>')
print('<body>')

connection = psycopg2.connect(login.credentials)
cursor = connection.cursor()
form = cgi.FieldStorage()
b_id = form.getvalue('b_id')


sql_delete_busbar = 'DELETE FROM busbar WHERE id = (%s);'      # DELETE busbar
sql_delete_ebusbar = 'DELETE FROM element WHERE id = (%s);'     # DELETE element
sql_delete_transformer = 'DELETE FROM transformer WHERE id =(%s);'  # DELETE transformer associated with busbar
sql_delete_etransformer = 'DELETE FROM element WHERE id = (%s);'
sql_delete_line = 'DELETE FROM line WHERE id = (%s);'  # DELETE line connected to busbar
sql_delete_eline = 'DELETE FROM element WHERE id = (%s);'  # DELETE line element
sql_delete_incident = 'DELETE FROM incident WHERE id =(%s);'  # DELETE incidents
sql_delete_lincident = 'DELETE FROM lineincident WHERE id = (%s);'  # DELETE lineincidents
sql_delete_analyses = 'DELETE FROM analyses WHERE id =(%s);'  # DELETE analyses where incident appears
sql_tid = 'SELECT id FROM transformer WHERE pbbid = (%s)' \
               'UNION SELECT id FROM transformer WHERE sbbid = (%s);'
sql_lid = 'SELECT id FROM line WHERE pbbid = (%s) ' \
           'UNION SELECT id FROM line WHERE sbbid = (%s);'

try:
    cursor.execute(sql_tid, [b_id, b_id])  # get transformer id
    tid = cursor.fetchall()
    for t_id in tid:
        cursor.execute(sql_delete_analyses, [t_id])      # delete transformer incident analyses
        cursor.execute(sql_delete_incident, [t_id])      # delete transformer incidents
        cursor.execute(sql_delete_transformer, [t_id])   # delete transformer
        cursor.execute(sql_delete_etransformer, [t_id])  # delete transformer element

    cursor.execute(sql_lid, [b_id, b_id])  # get line id
    lid = cursor.fetchall()
    for line_id in lid:
        cursor.execute(sql_delete_analyses, [line_id])      # delete line incident analyses
        cursor.execute(sql_delete_lincident, [line_id])              # delete line incidents
        cursor.execute(sql_delete_incident, [line_id])      # delete incidents
        cursor.execute(sql_delete_line, [line_id])  # delete line
        cursor.execute(sql_delete_eline, [line_id])  # delete line element

    cursor.execute(sql_delete_analyses, [b_id])  # delete busbar analyses
    cursor.execute(sql_delete_incident, [b_id])  # delete busbar incidents
    cursor.execute(sql_delete_busbar, [b_id])        # delete busbar
    cursor.execute(sql_delete_ebusbar, [b_id])        # delete busbar element

    connection.commit()
    cursor.close()
    print('<meta http-equiv="refresh" content="0; url=https://web.tecnico.ulisboa.pt/ist187010/busbar.cgi" />')
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))

print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/busbar.cgi">Return</a></p>')
print('</body>')
print('</html>')
