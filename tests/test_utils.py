from src.utils import format_greeting


def test_format_greeting():
    assert format_greeting("Alice") == "Hello Alice"
    assert format_greeting("Bob") == "Hello Bob"
