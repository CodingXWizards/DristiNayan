from flask import Flask, Response

App = Flask(__name__)
App.debug = True

@App.route('/', methods=['GET'])
def get():
    return ("Dristi Nayan Server")

if __name__ == '__main__':
    App.run(port = 8000)
