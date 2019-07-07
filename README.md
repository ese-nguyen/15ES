# FRIDAY
## Friday is a virture assistant help you deal with exist problem in nowadays retail store
Friday includes 4 parts:
- Chatbot - Natural language processing unit and feedback system
- Cross-platform apps for IOS and Android
- An systems to input databases for stores' owners (Develop in the future)
- Camera systems to tracking the shelves (Develop in the future)

## Outline
- [How to use chatbot](#How-to-use-chatbot)
- [How to deploy application](#How-to-deploy-application)

## Requirements:
- Python 3.6
- Flutter
- Android Studio
- Rasa 0.9.8
- SPaCy pretrained NLU models
- ngrok
- Firebase
- Additional packages
## How to use chatbot
Chat bot is build on **RASA** 0.9.8

**Training:**
```shell
python trainer.py train-all
```

**Testing:**
```python
from rasa_core.agent import Agent
agent = Agent.load('models/dialogue', interpreter=model_directory)
print("Your bot is ready to talk! Type your messages here or send 'stop'")
while True:
    a = input()
    if a == 'stop':
        break
    responses = agent.handle_message(a)
    for response in responses:
        print(response["text"])
```

**Deploy on local server**
```shell
python -m rasa_core.server -d models/dialogue -u models/nlu/default/current -o models/out.log
```
So the bot API will run in the localhost at port 5005

**Deploy on testing server**
```shell
ngrok http 5005
```
Then use the ngrok provided address to test the server.

**Call API**

Request a POST method to:
```
http:localhost:5000/conversations/default/respond
```
or
```
<your-provided-ngrok-address>/conversations/default/respond
```
Where the message has form:
```json
{"query": "your message"}
```
## How to deploy application
Open Android Studio and install the packages. Then run the commands
```shell
flutter run
```