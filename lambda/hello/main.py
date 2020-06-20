from classes.app import App


def handler(event, context):
    try:
        app = App()
        return app.get_params(event)
    except Exception as error:
        return {
            'statusCode': 200,
            'body': error
        }

