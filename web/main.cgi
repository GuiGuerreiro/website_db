#!/usr/bin/python3

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Program Menu</title>')

# put the text in the middle
print('<style>')
print('h1 {text-align: center;}')
print('p {text-align: center;}')
print('div {text-align: center;}')
print('</style>')

print('</head>')

print('<body>')

print('<h1>Connected to the APP</h1>')
print('<h2><a href="busbar.cgi">Bus bar</a></h2>')
print('<h2><a href="transformer.cgi">Transformer</a></h2>')
print('<h2><a href="substation.cgi">Substation</a></h2>')
print('<h2><a href="supervisor.cgi">Change Supervisor</a></h2>')
print('<h2><a href="incidents.cgi">Add Incidents/Edit Description</a></h2>')

print('</body>')
print('</html>')
