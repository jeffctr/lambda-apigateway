import json
from classes.hello import Hello


class App:

    def get_params(self, data):
        """ Check what is the callback and run it
            Parameters
            ----------
            data: dict

            Returns
            ----------
            response: dict

        """
        # Get data from the event
        contenxt = data.get('requestContext', {})
        query_params = data.get('queryStringParameters', {})

        # Instance the endpoints that are going to be able to trigger
        endpoints = {
            'hello': self.__call_hello,
        }

        # Split the path into a list
        paths = contenxt.get('path', '').split('/')
        # Get the parameters coming in the url
        params = data.get('pathParameters', {})
        # Search for the endpoints that should be in the path
        endpoint = paths[2] if len(paths) > 0 else None

        # This is a validation that check that there are params and the endpoint is valid
        if not params or endpoint not in endpoints:
            return {
                'statusCode': 200,
                'body': 'Not data available'
            }

        # Trigger the function to the correct endPoint
        response = endpoints[endpoint](paths, params, query_params)

        return {
            'statusCode': 200,
            'body': json.dumps(response)
        }

    @staticmethod
    def __call_hello(paths, params, query):
        """ Call the class Hello and run a specific target, In this case it would be world
            Note: Here you can run more functions but you need to validate each endpoint.

            Parameters
            ----------
            paths: list
                Getting more path of the endpoint Hello is possible to run different targets
            params: string
                Attributes coming in the GET method
            query: dict
                Attributes coming in the Query String Parameters

            Returns
            ----------
            response: dict
        """

        hello = Hello()
        return hello.get_world(json.loads(params))
