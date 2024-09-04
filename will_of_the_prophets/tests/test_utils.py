import os
import pytest
from unittest.mock import patch

from ..utils import get_boolean_env_variable


@pytest.mark.parametrize(
    "env_value, fallback_value, expected_result",
    [
        ("1", False, True),
        ("0", True, False),
        ("true", False, True),
        ("false", True, False),
        ("yes", False, True),
        ("no", True, False),
    ],
)
def test_get_boolean_env_variable(env_value, fallback_value, expected_result):
    with patch.dict(os.environ, {"TEST_VAR": env_value}):
        assert get_boolean_env_variable("TEST_VAR", fallback_value) == expected_result


def test_get_boolean_env_variable_fallback():
    with patch.dict(os.environ, {}, clear=True):
        assert get_boolean_env_variable("TEST_VAR", True) == True
        assert get_boolean_env_variable("TEST_VAR", False) == False
