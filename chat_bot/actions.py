from rasa_core.actions import Action
from rasa_core.events import SlotSet
from IPython.core.display import Image, display
import requests, json 
import requests

class FindLocationAction(Action):
    def name(self):
        return "action_find"

    def run(self, dispatcher, tracker, domain):
        url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=16.0746,108.2228&radius=2000&key=AIzaSyCBKmuwJus7aGghv1t_nskhG_y7vKPmCCM&name="
        name = tracker.get_slot("product")
        print(str(name))
        url += str(name)
        responses = requests.get(url)
        responses = responses.json()
        responses = responses['results'][:5]
        dispatcher.utter_message("Here is some place for you to buy:")
        for response in responses:
            dispatcher.utter_message(response['name'] + '\nAddress:' + response['vicinity'])
        
        