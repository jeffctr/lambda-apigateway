class Hello:

    def get_world(self, attribute):
        """ In this function you can create your logic
            ----------
            attribute : str

            Returns
            -------
            response : dict
        """
        return {
            "type": type(attribute),
            "len": len(attribute),
            "message": f'Hello {attribute} wellcome to this  world.'
        }
