import socket
import json
#import re
from flask import Flask, request

file_name="converted_emodji"

with open(file_name) as f:
    lines = f.read().strip().split('\n')
    res = []
    for i in lines:
        #res.append(re.sub(r'(\S+): (\S+)', r'\1:\2', i).split(':'))
        res.append(i.split(':'))
    emoji_dict = dict(res)

def animal_say(animal, sound, count, heart):
    result=""
    for i in range(int(count)):
        result+=f'{animal} say {sound}\n'
    #print(result)
    result+=f'Made with {heart} by Antosha\n'
    return result

# create the Flask app
app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def query_example():
    if request.method == 'POST':
    #a = [i for i in request.form]
    #print(a)
    #request_data = request.get_json()
    #print(request_data)
    #print(type(request_data))
        try:
            res = list(request.form.keys())[0]
            # print(type(res))
            res2 = json.loads(res)
            #print(emoji_dict.get(res2['animal'].upper()))
            return animal_say(emoji_dict.get(res2['animal'].upper()), res2['sound'], res2['count'], emoji_dict.get("SPARKLING HEART"))
        except:
            return f"""Use this format: {{animal:"dog", sound:"woof", count: 4}}"""+"\n"
    res_text = f"""
    Hello!<br/>
    Use one of these <a href="https://emojipedia.org/nature">emodji</a><br/><br/>
    Example:<br/>
    curl -XPOST -d'{{"animal":"cow", "sound":"moooo", "count": 3}}' http://{socket.gethostname()} or http://{socket.gethostbyname(socket.gethostname())}<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    Made with 💖 by Antosha"""
    return res_text


if __name__ == '__main__':
    # run app in debug mode on port 5000
    #app.run(debug=True, port=5000)
    context = ('cert.pem', 'key.pem')
    app.run(host="0.0.0.0", port=443, ssl_context=context)