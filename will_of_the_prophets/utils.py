import os
from distutils.util import strtobool


def get_boolean_env_variable(var_name: str, fallback_value: bool) -> bool:
    """
    Retrieves an environment variable with a boolean value and converts
    it to a boolean for use within this project.

    The reason that I've written this method is that .env files can cause problems
    when loading environment variables e.g. DEBUG=0 or DEBUG=False within
    .env can become DEBUG='false' (i.e. the string 'false') within
    e.g. settings.py.  This in turn causes problems e.g. bool('false')=True

    This method fetches the environment variable specified by `var_name`.
    If the variable is not found, it uses the `fallback_value` provided.
    The method then converts the string representation of the environment
    variable to a boolean.

    Args:
        var_name (str): The name of the environment variable.
        fallback_value (bool): The fallback value if the environment variable is not found.

    Returns:
        bool: The boolean value of the environment variable or the fallback value.
    """
    # Get the environment variable as a string, or use the fallback value if not set
    env_var = os.environ.get(var_name, str(fallback_value))

    try:
        # Convert the string representation to a boolean
        return bool(strtobool(env_var))
    except ValueError:
        # If strtobool fails, return the fallback_value
        return fallback_value
