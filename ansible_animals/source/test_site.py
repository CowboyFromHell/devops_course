import socket
from flask import Flask, request

#The file of list emodji
file_name="converted_emodji"

#Open the file for read
with open(file_name) as f:
    lines = f.read().strip().split('\n')
    res = [i.split(':') for i in lines]
    emoji_dict = dict(res) #The dictionary of emodji
    all_emodji = '"EMODJI"<br/>' #Text of emodji for page
    for key, value in emoji_dict.items():
        all_emodji+=f"{key}: {value}<br/>"

#The function for a POST request 
def animal_say(animal, sound, count, heart):
    result=""
    #Assembling a string
    for i in range(int(count)):
        result+=f'{animal} say {sound}\n'
    result+=f'Made with {heart} by Antosha\n'
    return result

# Create the Flask app
app = Flask(__name__)

#The root page
@app.route('/', methods=['GET', 'POST'])
def query_example():
    #Action for a POST request
    if request.method == 'POST':
        request_data = request.get_json(force=True) #Fetch a user data
        #Check the user data
        try:
            #Get keys from the user data and transfer for the function
            return animal_say(emoji_dict.get(request_data['animal'].upper()), request_data['sound'], request_data['count'], emoji_dict.get("SPARKLING HEART"))
        except:
            #If the user data is incorrect
            return f"""Use this format: {{animal:"dog", sound:"woof", count: 4}}"""+"\n"
    #The root page
    res_text = f"""
    Hello!<br/>
    Use one of these <a href="converted_emodji">emodji</a><br/><br/>
    Example:<br/>
    curl -XPOST -d'{{"animal":"cow", "sound":"moooo", "count": 3}}' https://{socket.gethostbyname(socket.gethostname())}<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    🐄 say moooo<br/>
    Made with 💖 by Antosha"""
    return res_text

#Page of emodji list
@app.route('/converted_emodji', methods=['GET', 'POST'])
def second_page():
    return all_emodji



if __name__ == '__main__':
    context = ('cert.pem', 'key.pem') #Self signed certificate
    app.run(host="0.0.0.0", port=443, ssl_context=context)