#!/usr/bin/python3

import psycopg2
import cgi

import login

form = cgi.FieldStorage()

new_busbar = form.getvalue('new_busbar')
voltage = form.getvalue('voltage')


print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Add Bus bar</title>')

# put the text in the middle
print('<style>')
print('h1 {text-align: center;}')
print('p {text-align: center;}')
print('div {text-align: center;}')
print('</style>')

print('</head>')

print('<body>')	

connection = None

try:
	# Creating connection
	connection = psycopg2.connect(login.credentials)
	cursor = connection.cursor()

	# Making query
	sql_element = 'INSERT INTO element VALUES (%s);'
	sql_bus_bar = 'INSERT INTO busbar VALUES (%s,%s);'
	data = (new_busbar, voltage)

	# Feed the data to the SQL query as follows to avoid SQL injection
	cursor.execute(sql_element, [new_busbar])
	cursor.execute(sql_bus_bar, [new_busbar, voltage])
	
	# Commit the update (without this step the database will not change)
	connection.commit()

	print('<meta http-equiv="refresh" content="0; url=https://web.tecnico.ulisboa.pt/ist187010/busbar.cgi" />')
except Exception as error_description:
	print('<h1>An error occurred.</h1>')
	print('<p>{}</p>'.format(error_description))
	print('<p><a href="https://web.tecnico.ulisboa.pt/ist187010/busbar.cgi">Return</a></p>')

finally:
	if connection is not None:
		connection.close()
	

print('</body>')
print('</html>')
